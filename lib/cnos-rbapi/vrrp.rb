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
## The Vrrp class provides a class implementation and methods for managing Vrrp 
## on the node. This class presents an abstraction
## 

class Vrrp
	@cfg  = '/nos/api/cfg/vrrp'
	# This API gets properties of all VRRP VRs of all interfaces.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_vrrp_prop_all(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API gets properties of all VRRP VRs under one specified interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface on switch
        #
        #  return: JSON response 		
	def self.get_vrrp_intf(conn, intf)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	
	# This API create a VRRP VR.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface on switch
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			    "if_name": "<if_name>",
        #  			    "vr_id": "<vr_id>",
        #  			    "ip_addr": "<ip_addr>",
        #  			    "ad_intvl": "<ad_intvl>",
        #  			    "preempt": "<preempt>",
        #  			    "prio": "<prio>",
        #  			    "admin_state": "<admin_state>",
        #  			    "track_if": "<track_if>",
        #  			    "accept_mode": "<accept_mode>",
        #  			    "switch_back_delay": "<switch_back_delay>",
        #  			    "v2_compt": "<v2_compt>"
        #  		}
        #  description - 
        #  if_name           :Interface name.Note: The interface must exist.
        #  vr_id             :Virtual Router (VR) identifier; an integer from 1‐255.
        #  ip_addr           :The IP address of the VR; a valid IPv4 address.
        #  ad_intvl          :Advertisement interval (The number of centi‐seconds between
        #  		     advertisements for VRRPv3); a multiple of 5 from 5‐4095. Default
        #                    value: 100 centi‐seconds.
        #  preempt           :Enable the preemption of a lower priority master; one of yes
        #                    (default) , no.
        #  prio              :The priority of the VR on the switch; an integer from 1‐254.
        #                     Default value: 100.
        #  admin_state       :Enable the VR one of up (default), down.
        #  oper_state        :The operation state of the VR; one of master, backup, init.
        #  track_if          :The interface to track by this VR. Default value: noneNote: If an interface is specified, it must exist.
        #  		     accept_mode Enables or disables the accept mode for this session; one of yes
        #  	             (default), no.	
        #  switch_back_delay :The switch back delay interval; an integer from 1‐500000, or 0 to
        # 		     disable (default).
        #  v2_compt          :Enables backward compatibility for VRRPv2 for the VR; one of
        # 		     yes, no (default). 	         	
        #
        #  return: JSON response
	def self.create_vrrp_intf(conn, intf, params)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg +  '/' + temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr,  params)
        end

	# This API gets properties of a VRRP VR.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface on switch
        #  vrid   - Virtual Router Identifier 1-255
        #
        # return: JSON response
	def self.get_vrrp_intf_vrid(conn, intf, vrid)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg +  '/' + temp + '/' + vrid.to_s)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end


	# This API updates the properties of a VRRP VR.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface on switch
        #  vrid   - Virtual Router Identifier 1-255
        #
	#  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			    "if_name": "<if_name>",
        #  			    "vr_id": "<vr_id>",
        #  			    "ip_addr": "<ip_addr>",
        #  			    "ad_intvl": "<ad_intvl>",
        #  			    "preempt": "<preempt>",
        #  			    "prio": "<prio>",
        #  			    "admin_state": "<admin_state>",
        #  			    "track_if": "<track_if>",
        #  			    "accept_mode": "<accept_mode>",
        #  			    "switch_back_delay": "<switch_back_delay>",
        #  			    "v2_compt": "<v2_compt>"
        #  		}
        #  		
        #  description - 
        #  if_name           :Interface name.Note: The interface must exist.
        #  vr_id             :Virtual Router (VR) identifier; an integer from 1‐255.
        #  ip_addr           :The IP address of the VR; a valid IPv4 address.
        #  ad_intvl          :Advertisement interval (The number of centi‐seconds between
        #  		     advertisements for VRRPv3); a multiple of 5 from 5‐4095. Default
        #                    value: 100 centi‐seconds.
        #  preempt           :Enable the preemption of a lower priority master; one of yes
        #                    (default) , no.
        #  prio              :The priority of the VR on the switch; an integer from 1‐254.
        #                     Default value: 100.
        #  admin_state       :Enable the VR one of up (default), down.
        #  oper_state        :The operation state of the VR; one of master, backup, init.
        #  track_if          :The interface to track by this VR. Default value: noneNote: If an interface is specified, it must exist.
        #  		     accept_mode Enables or disables the accept mode for this session; one of yes
        #  	             (default), no.	
        #  switch_back_delay :The switch back delay interval; an integer from 1‐500000, or 0 to
        # 		     disable (default).
        #  v2_compt          :Enables backward compatibility for VRRPv2 for the VR; one of
        # 		     yes, no (default). 	         	
        #
        #  return: JSON response
	def self.update_vrrp_intf_vrid(conn, intf, vrid, params)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg +  '/' + temp + '/' + vrid.to_s)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr,  params)
        end

	# This API Delete a VRRP VR.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface on switch
        #  vrid - Virtual Router Identifier 1-255
        #
        #  return: 
	def self.del_vrrp_intf_vrid(conn, intf, vrid)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + temp + '/' + vrid.to_s)
                hdr = form_hdr(conn)
                Rest.delete(conn, url, hdr)
        end

end
