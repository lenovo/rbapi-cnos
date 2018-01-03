##
## Copyright (c) 2017, Lenovo. All rights reserved.
##
## This program and the accompanying materials are licensed and made available
## under the terms and conditions of the 3-clause BSD License that accompanies
## this distribution.
##
## The full text of the license may be found at
##
## https://opensource.org/licenses/BSD-3-Clause
##
## THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
## WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
##
require 'rest-client'
require 'json'
require_relative 'connect'
require_relative 'rest_utils'



##
## The Telemetry class provides a class implementation and methods for managing Telemetry features 
## on the node. This class presents an abstraction
## 	

class Telemetry
	@cfg  = '/nos/api/cfg/telemetry'

	# This API gets system switch properties.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_sys_feature(conn)
                url = form_url(conn, @cfg + '/feature')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	 
	# This API sets system feature.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  	 "heartbeat­enable" :  1,        
        #  		   	 "msg­interval" :  10   
        #  		}
        #  description - 
        #  heartbeat-enable  :When enabled, the Agent asynchronously sends the registration
        #  	  	      and heartbeat message to the collector. One of:
        #  		      0: disable heartbeat
        #  		      1: enable heartbeat (default value)
        #  msg-interval      :Determines the interval with which the registration and heartbeat
        #  		      messages are sent to the collector; units of seconds from 1‐600.
        #  		      Default value: 5 seconds.
        #
        #  return: JSON response		      
	def self.set_sys_feature(conn, params)
                url = form_url(conn, @cfg + '/feature')
                hdr = form_hdr(conn)
		params = params.to_json
		Rest.put(conn, url, hdr, params)
	end

	# This API gets BST trackers and the tracking mode on the ASIC.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_bst_tracking(conn)
                url = form_url(conn, @cfg + '/bst/tracking')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API sets BST trackers and the tracking mode on the ASIC.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			"track­peak­stats" : 1,
        #  			"track­ingress­port­priority­group" : 1,
        #  			"track­ingress­port­service­pool" : 1,
        #  			"track­ingress­service­pool" : 1,
        #  			"track­egress­port­service­pool" : 1,
        #  			"track­egress­service­pool" : 1,
        #  			"track­egress­rqe­queue" : 1,
        #  			"track­device" : 1
        #  		}
        #  description -
        #  track­peak­stats                :Set to 1 to peak statistics tracking, 0 to disable
        #  				    this feature
        #  track­ingress­portpriority­group:Set to 1 to enable ingress port priority group
        #  				    tracking, 0 to disable this feature
        #  track­ingress­portservice­pool  :Set to 1 to enable ingress port service pool
        #  				    tracking, 0 to disable this feature
        #  track­ingress­servicepool       :Set to 1 to enable ingress service pool tracking,
        #  				    0 to disable this feature
        #  track­egress­portservice­pool   :Set to 1 to enable egress port service pool
        #  				    tracking, 0 to disable this feature
        #  track­egress­servicepool	   :Set to 1 to enable egress service pool tracking, 0
        #  				    to disable this feature
        #  track­egress­rqe­queue          :Set to 1 to enable egress RQE queue tracking, 0
        #  				    to disable this feature
        #  track­device 		   :Set to 1 to enable tracking of this device, 0 to
        #  				    disable this feature
        #
        #  return: JSON response				     
        def self.set_bst_tracking(conn, params)
                url = form_url(conn, @cfg + '/bst/tracking')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API gets BST information.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_bst_feature(conn)
                url = form_url(conn, @cfg + '/bst/feature')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API sets BST feature.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			"bst­enable": 1,
        #  			"send­async­reports": 1,
        #  			"collection­interval": 300,
        #  			"trigger­rate­limit": 5,
        #  			"trigger­rate­limit­interval": 2,
        #  			"send­snapshot­on­trigger": 1,
        #  			"async­full­reports": 1,
        #  		}
        #  description -
        #  bst­enable         		:Set to 1 to enable BST, 0 to disable it. Enabling BST
        #  		       	 	 allows the switch to track buffer utilization
        #  		         	 statistics.
        #  send­async­reports   	:Set to 1 to enable the transmission of periodic
        # 			 	 asynchronous reports, 0 to disable this feature.
        #  collection­interval  	:The collection interval, in seconds. This defines how
        #  			 	 frequently periodic reports will be sent to the
        #  			 	 configured controller.
        #  trigger­rate­limit   	:The trigger rate limit, which defines the maximum
        #  				 number of threshold‐driven triggered reports that
        #  			 	 the agent is allowed to send to the controller per
        #  			 	 trigger­rate­limit­interval; an integer
        #  			 	 from 1‐5.
        #  trigger­rate­limit-interval :The trigger rate limit interval, in seconds; an integer
        #  from 10‐60.
        #  send­snapshot­ontrigger     :Set to 1 to enable sending a complete snapshot of all
        #  				buffer statistics counters when a trigger happens, 0
        #  				to disable this feature.
        #  async­full­report 	       :Set to 1 to enable the async full report feature, 0 to
        #  				disable it.
        #  				When this feature is enabled, the agent sends full
        # 				reports containing data related to all counters.
        #  				When the feature is disabled, the agent sends
        #  				incremental reports containing only the counters
        #  				that have changed since the last report.
        #
        #  return: JSON response			
        def self.set_bst_feature(conn, params)
                url = form_url(conn, @cfg + '/bst/feature')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API gets BST report information.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_bst_report(conn, params)
                temp = @cfg.dup
                temp.sub! 'cfg', 'info'
                url = form_url(conn, temp + '/bst/report')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)
        end
	
	# This API gets BST threshold.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_bst_threshold(conn, params)
                url = form_url(conn, @cfg + '/bst/threshold')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)
        end

	# This API sets BST threshold to trigger BST reports.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs for the realms 
        #  	    given in description
        #  		{
        #  			"realm": "ingress­service­pool",       
        #  			"service­pool" : 0,
        #  			"um­share­threshold" : 70
        #  		}
        #  description - 
        #
        #  return: JSON response				
        def self.set_bst_threshold(conn, params)
                url = form_url(conn, @cfg + '/bst/threshold')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API clears  BST threshold.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.clear_bst_threshold(conn)
                url = form_url(conn, @cfg + '/bst/clear/threshold')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API clear BST statistics.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.clear_bst_stats(conn)
                url = form_url(conn, @cfg + '/bst/clear/statistics')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API clears BST congestion drops.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.clear_bst_cgsn_ctrs(conn)
                url = form_url(conn, @cfg + '/clear-cgsn-drop-counters')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end


end





