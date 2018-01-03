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
## The Stp class provides a class implementation and methods for managing the STP 
## on the node. This class presents an abstraction
## 

class Stp
	@cfg  = '/nos/api/cfg/stp/interface'
	# This API gets STP properties of all interfaces.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_all_stp(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API gets STP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #
        #  return: JSON response 		
	def self.get_stp_intf(conn, intf)
		intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + intf)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)	
        end


	# This API updates STP properties of one interface.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			 "if_name":  "<if_name>",
        #  			  "edge_port":  "<edge_port>",
        #  			  "bpdu_guard":  "<bpdu_guard>",
        #  			  "loop_guard":  "<loop_guard>",
        #  			  "root_guard":  "<root_guard>"
        # 		}
        #  description -
        #  if_name 	:The IP interface name; a string.
        #  		 Note: The interface must exist.
        #  edge_port 	:Whether the interface is configured as an edge port, which allows
        #  		 the port to automatically transition to the STP forwarding state;
        #  		 one of yes, no. Default value: yes.
        #  bpdu_guard   :(Optional) Whether BPDU guard is enabled on a port, which
        #  		 automatically shuts down the interface upon receipt of a BPDU;
        #  		 one of enable, disable. Default value: disable.
        #  loop_guard 	:(Optional) Whether look guard is enabled on a port for additional
        #  		 checks for preventing STP looping; one of enable, disable.
        # 		 Default value: disable.
        #  root_guard 	:(Optional) Whether guard mode is set to root guard on interface
        #
        #  return: JSON response
        def self.update_stp(conn, intf, params)
		intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/' + intf)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end
end
