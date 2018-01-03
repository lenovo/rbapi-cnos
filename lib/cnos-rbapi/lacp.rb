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
## The Lacp class provides a class implementation and methods for managing Lacp 
## on the node. This class presents an abstraction
## 

class Lacp
	@cfg  = '/nos/api/cfg/lacp'
	# This API gets the LACP properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
        def self.get_lacp(conn)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		Rest.get(conn, url ,hdr)
        end
	
	# This API updates the LACP properties of the system.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  sys_prio - System Priority
        #  params - dictionary that requires the following format of key-value pairs
        #  	    {	
        #  	    	  "sys_prio": "<sys_prio>",
        #  	    }
        #  description -
        #  sys_prio   :LACP system priority; a positive integer from 1‐65535. Default
        #  	       value: 32768.
        #
        #  return: JSON response	       
	def self.update_lacp(conn, params)
                url = form_url(conn, @cfg)
                hdr = form_hdr(conn)
		params = params.to_json
		Rest.put(conn, url, hdr, params)

        end

end
