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
## The Igmp class provides a class implementation and methods for managing the IGMP 
## on the node. This class presents an abstraction
## 
class Igmp
	@cfg  = '/nos/api/cfg/igmp'
	
	#  This API gets IGMP Snooping properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_igmp_snoop_prop(conn)
                url = form_url(conn, @cfg + '/snoop')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	#  This API update the global IGMP Snooping properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                {
        #                	 "ena_igmp_snoop": "<ena_igmp_snoop>"
        #                }
        #  description -              
        #  ena_igmp_ snoop  :Enables IGMP snooping globally on all VLANs; one of yes
        #  		     (default), no.
        #  	             If disabled globally, IGMP snooping is disabled on all VLANs,
        #  	             regardless of the per‐VLAN setting of IGMP snooping. If IGMP
        #  		     snooping is enabled globally, the per‐VLAN setting of IGMP
        #  		     snooping takes effect.              	
        #
        #
        #  return: JSON response 		
        def self.set_igmp_snoop_prop(conn, params)
                url = form_url(conn, @cfg + '/snoop')
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	#  This API gets IGMP Snooping properties of one VLANs.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_id - VLAN number
        #
        #  return: JSON response 		
	def self.get_igmp_vlan_prop(conn, vlan_id)
		temp = @cfg.dup
		temp.sub! 'igmp', 'mc_vlan/' + vlan_id.to_s	
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	#  This API update the global IGMP Snooping properties of the specified VLAN.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_id - VLAN number
        #  params - dictionary that requires the following format of key-value pairs
        #                {
        #                	    "vlan_id": "<vlan_id>",
        #                	    "ena_igmp_snoop": "<ena_igmp_snoop>",
        #                	    "fast_leave": "<fast_leave>",
        #                	    "query_interval": "<query_interval>",
        #                	    "version": "<version>",
        #                }
        #  description - 
        #  vlan_id        :VLAN number.Note: The VLAN must exist.
        #  ena_igmp_snoop :(Optional) Whether to enable IGMP snooping on a VLAN; one of
        #  		    yes, no. Default value: yes.
        #  fast_leave     :One of yes, no. Default value: no.
        #  query_interval :(Optional) IGMP query interval, in seconds; an integer from
        #  		    1‐18000. Default value: 125.
        #  version        :(Optional) IGMP Snooping version number; one of 2, 3. Default
        #  		    value: 3   
        #
        #  return: JSON response		            
        def self.set_igmp_vlan_prop(conn, vlan_id, params)
		temp = @cfg.dup
                temp.sub! 'igmp', 'mc_vlan/' + vlan_id.to_s
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end
end
