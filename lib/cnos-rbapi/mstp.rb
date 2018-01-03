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
## The Mstp class provides a class implementation and methods for managing Mstp 
## on the node. This class presents an abstraction
## 

class Mstp
	@cfg  = '/nos/api/cfg/mstp'
	# This API gets global MSTP properties of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_mstp_sys_prop(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates MSTP properties of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "region_name": "<region_name>"
        #  		  "revision": "<revision>"
        #  		}
        #  description - 
        #  region_name  :Region name; a string up to 32 characters long.
        #  revision     :Revision number; an integer from 0‐65535.
        #
        #  return: JSON response 		
	def self.update_mstp_sys_prop(conn, params)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)

        end

	# This API gets properties of all MSTP instances
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_mstp_inst_all(conn)
                url = form_url(conn, @cfg + '_instance')
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API creates an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		 "instance_id": "<instance_id>",
        #  		  "instance_prio": "<instance_prio>",
        #  		  "vlans": [
        #  		    {
        #  		      "vlan_id": "<vlan_id>"
        #  		    }
        #  		  ]
        #  		}
        #  description -
        #  instance_id   :MST instance ID; an integer from 0‐64. Instance 0 refers to the
        #  		  CIST.
        #  instance_prio :Sets the instance bridge priority; an integer from 0‐61440. Default
        #  		  value: 32768.
        #  vlans         :Maps a range of VLANs to a multiple spanning tree instance
        #  		  (MSTI); an integer from 1‐4094.
        #
        #  return: JSON response 		
	def self.create_mstp_inst(conn, params)
                url = form_url(conn, @cfg + '_instance')
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.post(conn, url, hdr, params)
        end

	# This API gets properties of an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_mstp_inst(conn, inst_id)
                url = form_url(conn, @cfg + '_instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
        
	# This API updates the properties of an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		 "instance_id": "<instance_id>",
        #  		  "instance_prio": "<instance_prio>",
        #  		  "vlans": [
        #  		    {
        #  		      "vlan_id": "<vlan_id>"
        #  		    }
        #  		  ]
        #  		}
        #  description -
        #  instance_id   :MST instance ID; an integer from 0‐64. Instance 0 refers to the
        #  		  CIST.
        #  instance_prio :Sets the instance bridge priority; an integer from 0‐61440. Default
        #  		  value: 32768.
        #  vlans         :Maps a range of VLANs to a multiple spanning tree instance
        #  		  (MSTI); an integer from 1‐4094. 
	#
	#  return : JSON response
	def self.update_mstp_inst(conn, inst_id, params)
                url = form_url(conn, @cfg + '_instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)

        end

	# This API deletes an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.del_mstp_inst(conn, inst_id)
                url = form_url(conn, @cfg + '_instance/' + inst_id.to_s)
                hdr = form_hdr(conn)
                Rest.delete(conn, url, hdr)
        end

	# This API gets interface properties of an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - instance id
        #  intf - interface in the MSTP instance 
        #
        #  return: JSON response 		
	def self.get_mstp_inst_intf(conn, inst_id, intf)
		intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '_instance/' + inst_id.to_s + '/' + intf )
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates interface properties of an MSTP instance
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  inst_id - instance id
        #  intf - interface in the MSTP instance 
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "if_name": "<if_name>",
        #  		  "path_cost": "<path_cost>",
        #  		  "port_prio": "<port_prio>"
        #  		}
        #  description -
        #  if_name    :Interface name.Note: The interface must exist.
        #  path_cost  :The port path‐cost value on the specified MST instance; either an
        #  		integer from 1‐200000000 or auto (default) to base the path‐cost
        #  		on port speed.
        #  port_prio  :The port priority, in increments of 32, on the specified MST
        #  		instance; a multiple of 32 from 0‐224. Default value: 128.
        #  return: JSON response
	def self.update_mstp_inst_intf(conn, inst_id, intf, params)
                intf.sub! '/', '%2F'
                url = form_url(conn, @cfg + '_instance/' + inst_id.to_s + '/' + intf )
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.put(conn, url, hdr, params)

        end

end

