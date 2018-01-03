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
## The Vlag class provides a class implementation and methods for managing the Vlags 
## on the node. This class presents an abstraction
## 

class Vlag
	@cfg  = '/nos/api/cfg/vlag'

	# This API gets VLAG global configuration.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_vlag_conf(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API updates VLAG global configuration.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		 	"status": "<status>",
        #  		  	"tier_id": "<tier_id>",
        #  		  	"priority": "<priority>",
        #  		  	"auto_recover" : "<auto_recover>",
        #  		  	"startup_delay": "<startup_delay>",
        #  		}
        #  description - 
        #  status        :Whether the vLAG is enabled or disabled; one of enable, disable.
        #  	          Default value; disable
        #  tier_id       :vLAG tier ID value; an intger from 1‐512. Default value: 0.
        #  priority      :vLAG priority value; an integer from 0‐65535. Default value: 0.
        #  auto_recover  :Time interval, in seconds; an integer from 240‐3600. Default
        #  		  value: 300.
        #  startup_delay :Delay time, in seconds; an integer from 0‐3600. Default value: 120	
        #
        #  return: JSON response	
	def self.update_vlag_conf(conn, params)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end

	# This API gets global VLAG information.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_global_vlag(conn)
		temp = @cfg.dup
		temp.sub! 'cfg' , 'info'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API gets VLAG Inter Switch Link Information.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_vlag_isl(conn)
		temp = @cfg.dup
		temp.sub! 'cfg' , 'info'
                url = form_url(conn, temp + '/isl')
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API configures the port aggregator for the VLAG ISL.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			 "port_aggregator": ʺ<port_aggregator>ʺ
        #  		}
        #  description -
        #  port_aggregator :Port aggregator for the vLAG ISL. 
        #
        #  return: JSON response
	def self.update_vlag_isl(conn, params)
                url = form_url(conn, @cfg + '/isl')
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end
	
	# This API gets VLAG health check information.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_vlag_health(conn)
                temp = @cfg.dup
                temp.sub! 'cfg' , 'info'
                url = form_url(conn, temp + '/health_check')
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API configures the VLAG health check parameters
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			  "peer_ip": "<peer_ip>",
        #  			  "vrf": "<vrf>",
        #  			  “retry_interval": "<retry_interval>",
        #  			  "keepalive_attempts" : "<keepalive_attempts>",
        #  			  "keepalive_interval" : "<keepalive_interval>",ʺ
        #  		}
        #  description -
        #  peer_ip            :IP address of peer switch. This can be the management IP address
        #  		       of the peer switch.
        #  vrf                :VRF context string.
        #  retry_interval     :Time interval, in seconds; an integer from 1‐300. Default value:
        # 		       30.
        #  keepalive_attempts :Number of keepalive attempts made before declaring the peer is
        #  		       down; an integer from 1‐24. Default value: 3.
        #  keepalive_interval :Time interval, in seconds; an integer from 2‐300. Default value: 5	
        #  
        #  return: JSON response
	def self.update_vlag_health(conn, params)
                url = form_url(conn, @cfg + '/health_check')
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end
	
	# This API creates a VLAG instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			  "inst_id": "<inst_id>",
        #  			  "port_aggregator": "<port_aggregator>",
        #  			  "status": "<status>",
        #  		}
        #  description -
        #  inst_id          :vLAG instance ID number; an integer from 1‐64.
        #  port_ aggregator :LAG identifier; an integer from 1‐4096.
        #  status           : vLAG status; one of enable, disable. Default value: disable.
        #
        #  return: JSON response
	def self.create_vlag_inst(conn, params)
                url = form_url(conn, @cfg + '/instance')
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.post(conn, url, hdr, params)

        end

	# This API updates VLAG instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - Vlan instance ID number 
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			  "port_aggregator": "<port_aggregator>",
        #  			  "status": "<status>",
        #  		}
        #  description -
        #  port_ aggregator :LAG identifier; an integer from 1‐4096.
        #  status           : vLAG status; one of enable, disable. Default value: disable.
        #
        #  return: JSON response
	def self.update_vlag_inst(conn, inst_id, params)
                url = form_url(conn, @cfg + '/instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.post(conn, url, hdr, params)

        end

	# This API deletes a  Vlag Instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - Vlag instance ID number 
        #
        # return: JSON response
	def self.delete_vlag_inst(conn, inst_id)
		url = form_url(conn, @cfg + '/instance/' + inst_id.to_s)
		hdr = form_hdr(conn)
		Rest.delete(conn, url, hdr)
        end
	
	# This API gets configuration paramteres for the specified VLAG instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - Vlag instance ID number
        #
        #  return: JSON response 		
	def self.get_vlag_inst_confg(conn, inst_id)
                url = form_url(conn, @cfg + '/instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
       
	# This API gets configuration paramteres for all  VLAG instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_all_vlag(conn)
                url = form_url(conn, @cfg + '/instance')
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end

	# This API get information about a VLAG instance.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - Vlag instance ID number
        #
        #  return: JSON response 		
	def self.get_vlag_inst_info(conn, inst_id)
		temp = @cfg.dup
                temp.sub! 'cfg' , 'info'
		url = form_url(conn, temp + '/instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
end
