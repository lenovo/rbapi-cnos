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
## The Ipintf class provides a class implementation and methods for managing the Ip Interfaces 
## on the node. This class presents an abstraction
## 

class Ipintf
	@cfg  = '/nos/api/cfg/ip_interface'
	# This API gets the IP properties of all interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_ip_prop_all(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	 
	# This API gets the IP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #
        #  return: JSON response 		
	def self.get_ip_prop_intf(conn, intf)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the IP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		    "if_name": "<if_name>",
        #  		    "bridge_port": "<bridge_port>",
        #  		    "mtu": "<mtu>",
        #  		    "ip_addr": "<ip_addr>",
        #  		    "ip_prefix_len": "<ip_prefix_len>",
        #  		    "vrf_name": "<vrf_name>",
        #  		     "admin_state": "<admin_state>"
        # 		}
        #  description -
        #  if_name      :IP interface name (String).Note: The interface must exist.
        #  bridge_port  :Whether or not the port is a bridge port; one of yes (default), no.
        #  mtu          :The maximum transmission unit, in bytes; an integer from
        #  		 64‐9216. Default value: 1500.
        #  ip_addr      :IP address for the interface.
        #  ip_prefix_len:IP address mask; a positive integer from 1‐32.
        #  vrf_name     :The name of the VRF to which the interface belongs. Note: The named VRF must exist.
        #  admin_state  :The admin status; one of up, down
        #
        #  return: JSON response
	def self.update_ip_prop_intf(conn, intf, params)
                temp = intf.dup
                temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

end
