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
## The Lag class provides a class implementation and methods for managing Lag 
## on the node. This class presents an abstraction
## 

class Lag
	@cfg  = '/nos/api/cfg/lag'
	
	# This API gets the properties of all LAG's.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_all_lag(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end

	# This API creates a Lag.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			"lag_id": "<lag_id>",
        #  			"interfaces": [
        #  		  	{
        #  		    		"if_name": "<if_name>",
        #  		    		"lag_mode": "<lag_mode>",
        #  		    		"lacp_prio": "<lacp_prio>",
        #  		    		"lacp_timeout": "<lacp_timeout>"
        #  		  	}
        #  			]
        # 		}
        #  description -
        #  lag_id       :LAG identifier; a positive integer from 1‐4096.
        #  interfaces   :Physical interface members of the LAG. Up to 32 interfaces can be
        #  	       added.
        #  if_name      :Ethernet interface name (String).Note: The interface must exist.
        #  lag_mode     :LAG mode; one of lacp_active, lacp_passive, no_lacp.
        #  lacp_prio    :(Optional) LACP priority for the physical port; a positive integer
        #  		from 1‐65535. Default value: 32768.
        #  lacp_timeout :(Optional) LACP timeout for the physical port; one of short,
        #  		 long. Default value: long.
        #
        #  return: JSON response		 
        def self.create_lag(conn, lag_id, interfaces = [])
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                params = {"lag_id" => lag_id, "interfaces" => interfaces}.to_json
                Rest.post(conn, url, hdr, params)
        end

	# This API gets properties of the specified LAG.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_lag_prop(conn, lag_id)
                url = form_url(conn, @cfg + '/' + lag_id.to_s)
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
        #  			{
        #  			    "lag_name":  "<lag_name>",
        #  			    "lag_id":  "<lag_id>",
        #  			    "interfaces": [
        #  			      {
        #  			        "if_name":  "<if_name>",
        #  			        "lag_mode":  "<lag_mode>",
        #  			        "lacp_prio":  "<lacp_prio>",
        #  			        "lacp_timeout":  "<lacp_timeout>"
        #  			      }
        #  			    ],
        #  			    "suspend_individual":  "<status>",
        #  			    "min_links":  "<min_links>",
        #  			}
        #  			
        #  		}
        #  description -
        #  lag_name 	      :The name of the LAG; a string.
        #  lag_id             :LAG identifier; an integer from 1‐65535
        #  interfaces 	      :Physical interface members of the LAG; an integer from 1‐32.
        #  if_name 	      :Ethernet interface name.
        #  		       Note: The interface must exist.
        #  lag_mode 	      :LAG mode; one of lacp_active, lacp_passive, no_lacp.
        #  lacp_prio 	      :LACP priority for the physical port; an integer from 1‐65535.
        #  Default value      : 32768.
        #  lacp_timeout       :LACP timeout for the physical port; one of short, long. Default
        #  value: long.
        #  suspend_individual :If the LAG does not get the LACP BPUD from peer ports the port
        #  		      aggregation, the result is one of the following:
        #   		      Yes ‐  LACP on the the ports is suspended rather than put into
        #  			     individual state.
        #   		      No  - LAG on the ports is put into individual state.
        #  Default value      :No.
        #  min_links          :LACP minimum links number; an integer from 1‐65535.
        #  		       Default value: 1.
        #
        #  return: JSON response		 
        def self.update_lag(conn, lag_id, params)
                url = form_url(conn, @cfg + '/' + lag_id.to_s)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end

	# This API gets load balance properties for port agregations.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_load_balance(conn)
                url = form_url(conn, @cfg + '/load_balance')
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end

	# This API updates the load balance properties for port aggregations.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  			  "destination­ip"   : "<destination‐ip>"
        #  			  "destination­mac"  : "<destination‐mac>"
        #  			  "destination­port" : "<destination‐port>"
        #  			  "source­dest­ip"   : "<source‐dest‐ip>"
        #  			  "source­dest­mac"  : "<source‐dest‐mac>"
        #  			  "source­dest­port" : "<source‐dest‐port>"
        #  			  "source­interface" : "<source‐interface>"
        #  			  "source­ip"        : "<source‐ip>"
        #  			  "source­mac"       : "<source‐mac>"
        #  			  "source­port”      : "<source‐port>"
        #  		}
        #  description -
        #  destination‐ip    :Load distribution on the destination IP address.
        #  destination‐mac   :Load distribution on the destination MAC address.
        #  destination‐port  :Load distribution on the destination TCP/UDP port.
        #  source‐dest‐ip    :Load distribution on the source and destination IP address.
        #  source‐dest‐mac   :Load distribution on the source and destination MAC address.
        #  source‐dest‐ port :Load distribution on the source and destination TCP/UDP port.
        #  source‐ interface :Load distribution on the source ethernet interface.
        #  source‐ip         :Load distribution on the source IP address.
        #  source‐mac        :Load distribution on the source MAC address.
        #  source‐port       :Load distribution on the source TCP/UDP port.
        #
        #  return: JSON response
        def self.update_lag_load_balance(conn, params)
                url = form_url(conn, @cfg + '/load_balance')
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)
        end

	# This API deletes specified LAG.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return:  		
        def self.delete_lag(conn, lag_id)
                url = form_url(conn, @cfg + '/' + lag_id.to_s)
                hdr = form_hdr(conn)
		Rest.delete(conn, url, hdr)
        end
end

