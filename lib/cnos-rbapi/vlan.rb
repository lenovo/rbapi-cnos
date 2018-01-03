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
## The Vlan class provides a class implementation and methods for managing the VLANs 
## on the node. This class presents an abstraction
## 
#

class Vlan
	@cfg = '/nos/api/cfg/vlan'

	# This API gets properties of all VLANS.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_all_vlan(conn)
		url = form_url(conn, @cfg)
		hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
	end
	
	# This API creates a Vlan.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  	    {
        #  	    	  "vlan_name": "<vlan_name>",
        #  	    	  "vlan_id": "<vlan_id>",
        #  	    	  "admin_state": "<admin_state>",	
        #  	    }
        #  description -
        #  vlan_name 	:VLAN name; a string up to 32 characters long. To create a VLAN
        #  		 with the default name, the vlan_name field must be null.
        #  vlan_id 	:VLAN number.; an integer from 2‐3999.
        #  admin_state  :The admin status; one of up, down
        #
        #  return: JSON response
	def self.create_vlan(conn, params)
		url = form_url(conn, @cfg)
		hdr = form_hdr(conn)
		params = params.to_json
		Rest.post(conn, url, hdr, params)

	end
	
	# This API gets properties of a vlan.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_id - VLAN number
        #
        #  return: JSON response 		
	def self.get_vlan_prop(conn, vlan_id)
		url = form_url(conn, @cfg + '/' + vlan_id.to_s)
                hdr = form_hdr(conn)
		Rest.get(conn, url, hdr)
        end
	
	# This API updates properties of a VLAN.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_id - VLAN number
        #  params - dictionary that requires the following format of key-value pairs
        #  	    {
        #  	    	 "vlan_name": "<vlan_name>",
        #  	    	 "admin_state": "<admin_state>"	
        #  	    }
        #  description -
        #  vlan_name   :VLAN name; a string up to 32 characters long. To change a VLAN
        #  		name with default name, the vlan_name field must be null.
        #  admin_state :The admin status; one of up, down
        #
        #  return: JSON response	       
	def self.update_vlan(conn, vlan_id,  params)
		url = form_url(conn, @cfg + '/' + vlan_id.to_s)
                hdr = form_hdr(conn)
                params = params.to_json
		Rest.put(conn, url, hdr, params)

        end

	# This API deletes a  vlan.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  vlan_id - VLAN number 
        # 	     Note: If the specified vlan_id is all, all user‐created VLANs will be deleted.
        #
        # return: 
	def self.delete_vlan(conn, vlan_id)
		url = form_url(conn, @cfg + '/' + vlan_id.to_s)
                hdr = form_hdr(conn)
		Rest.delete(conn, url, hdr)
	end
		
end
