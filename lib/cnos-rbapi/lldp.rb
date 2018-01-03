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
## The Lldp class provides a class implementation and methods for managing LLdp 
## on the node. This class presents an abstraction
## 

class Lldp
	@cfg  = '/nos/api/cfg/lldp'
	
	# This API gets global LLDP properties of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_lldp_prop(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the global LLDP properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  	  	  "reinit delay": "<reinit delay>",
        #  	  	  "transit interval": "<transmit interval>",
        #  	  	  "transmit delay": "<transmit delay>"
        #  	  	}
        # description - 
        # reinit delay      :The number of seconds until LLDP re‐initialization is attempted
        #                    on an interface; an integer from 1‐10. Default value: 2 seconds.
        # transmit interval :The time interval, in seconds, between transmissions of LLDP
        #                    messages; an integer from 5‐32768.. Default value: 30 seconds.
        # transmit delay    :The number of seconds for transmission delay; an integer from
        #                    1‐8192. Default value: 2 seconds.
        #
        #  return: JSON response 		
	def self.update_lldp_prop(conn, params)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)

        end
	
	# This API gets global LLDP properties of all interfaces
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_lldp_all_intf(conn)
                url = form_url(conn, @cfg + '/lldp_interface')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API gets global LLDP properties of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #
        #  return: JSON response 		
	def self.get_lldp_intf(conn, intf)
		intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/lldp_interface/' + intf)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API updates the LLDP properties of one interface
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			 "if_name": "<if_name>",
        #  			 "ena_lldp_rx": "<ena_lldp_rx>",
        #  			 "ena_lldp_tx": "<ena_lldp_tx>"	
        #  		}
        # description -
        # 
        # if_name       :Ethernet interface name (String).Note: The Ethernet interface must exist.
        # ena_lldp_rx   :Enables or disables LLDP frame reception on a physical interface;
        # 	       	 one of yes (default), no.
        # ena_lldp_tx   :Enables or disable sLLDP frame transmission on a physical
        # 		 interface; one of yes (default), no. 
        #
        #
        # return: JSON response		 
	def self.update_lldp_intf(conn, intf, params)
                intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/lldp_interface/' + intf)
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.put(conn, url, hdr, params)
        end
	
	# This API gets LLDP interface statistics per interface
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #
        #  return: JSON response 		
	def self.get_lldp_intf_stats(conn, intf)
                intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/lldp_interface/statistics/' + intf)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
 	
	# This API gets LLDP interface neighbour information
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  intf - Interface name
        #
        #  return: JSON response 		
	def self.get_lldp_intf_neighbor(conn, intf)
                intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '/lldp_interface/neighbor/' + intf)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API gets LLDP neighbour information for all interfaces
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 
	def self.get_lldp_intf_neighbor_all(conn)
                url = form_url(conn, @cfg + '/lldp_interface/neighbor')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

end


