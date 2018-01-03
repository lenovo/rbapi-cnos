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
## The Arp class provides a class implementation and methods for managing the ARP 
## on the node. This class presents an abstraction
## 

class Arp
	@cfg  = '/nos/api/cfg/arp'
        
	# This API gets the ARP properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_arp_sys_prop(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API gets the ARP properties of all interfaces.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_arp_prop_all(conn)
                url = form_url(conn, @cfg + '_interface')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the ARP properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #    		  “ageout_time” : “<ageout_time>”
        # 		}
        #  description -
        #  ageout_time :The global ARP entry age‐out time, in seconds; an integer from 60‐28800.  Default value: 1500 seconds. 
        #
	#  return: JSON response 		
        def self.set_arp_sys_prop(conn, params)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API gets the ARP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_arp_intf_prop(conn, intf)
                temp = intf.dup
		temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '_interface/' + temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the ARP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "if_name": "<if_name>",
        #    		  “ageout_time” : “<ageout_time>”
        # 		}
        #  description -
        #  if_name     :IP interface name (String).Note: The interface must exist.
        #  ageout_time :The global ARP entry age‐out time, in seconds; an integer from 60‐28800.  Default value: 1500 seconds. 
        #
	#  return: JSON response 		
        def self.set_arp_intf_prop(conn, intf,  params)
                temp = intf.dup
		temp.sub! '/', '%2F'
                url = form_url(conn, @cfg + '_interface/' + temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

end

