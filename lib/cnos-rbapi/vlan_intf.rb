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
## The VlanIntf class provides a class implementation and methods for managing the Vlan Interfaces 
## on the node. This class presents an abstraction
## 


class VlanIntf
	@cfg = '/nos/api/cfg/vlan_interface'
	# This API gets VLAN properties of all Ethernet interfaces.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_all_vlan_intf(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API gets VLAN properties of an Ethernet Interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_intf - Interface 
        #
        #  return: JSON response 		
        def self.get_vlan_prop_intf(conn, vlan_intf)
		temp = vlan_intf.dup
		temp.sub! '/', '%2F'
		url = form_url(conn, @cfg + '/' + temp) 
		hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API updates properties of  a Lag.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #
        #  		 	"if_name": "<if_name>",
        #  		 	“bridgeport_mode”: “<bridgeport_mode>”
        #  		 	“pvid”: "<pvid>",
        #  		 	“vlans”: ["<vlan_id>"]
        #  		} 
        #  description - 
        #  if_name 	    :Ethernet interface name (String).Note: The Ethernet interface must exist.
        #  bridgeport_ mode :Bridge port mode; one of access, trunk
        #  pvid             :Native VLAN for a port (the access VLAN for access ports or the
        #  		      native VLAN for trunk ports); an integer from 1‐3999. Default
        #                     value: 1.
        #  vlans            :(Optional) VLAN memberships; all, none, or an integer from
        #  		     1‐3999.
        #
        #  return: JSON response 		     
	def self.update_vlan_intf(conn, vlan_intf, params)
		temp = vlan_intf.dup
		temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + temp)
		hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end

end
