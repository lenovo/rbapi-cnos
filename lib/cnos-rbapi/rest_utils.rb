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

##
## The Rest class provides a class implementation and methods for executing REST methods such as GET, POST, PUT and DELETE  
## on the node. This class presents an abstraction
## 

class Rest
	# This API performs GET request for the given url and switch connection.
	#        
	#              
	# parameters:
	# conn - connection object to the node
	# url - URL for the GET request
	# hdr - header paramters for the GET request
	#                                                    
	# return: JSON response
	def self.get(conn, url, hdr)
		begin
                        resp = RestClient::Request.execute method: :get, url: url, headers: hdr, user: conn.getUser, password: conn.getPassword, timeout: 20 ,:verify_ssl => false
                        response = JSON.parse(resp)
                        response
                rescue RestClient::ExceptionWithResponse => err
                        puts err
			puts err.response.match(/<p>(.+)<\/p>/)[1]

                end
	
	end
	
	# This API performs PUT request for the given url and switch connection.
	#        
	#              
	# parameters:
	# conn - connection object to the node
	# url - URL for the PUT request
	# hdr - header paramters for the PUT request
	# params - JSON body for POST request
	#                                                    
	# return: JSON response
	def self.put(conn, url, hdr, params)
		begin
                        resp = RestClient::Request.execute method: :put, url: url, headers: hdr, payload: params, user: conn.getUser, password: conn.getPassword, timeout: 20 ,:verify_ssl => false
                        response = JSON.parse(resp)
                        response
		rescue RestClient::ExceptionWithResponse => err
                        puts err
			puts err.response.match(/<p>(.+)<\/p>/)[1]
                end

	end
	
	# This API performs POST request for the given url and switch connection.
	#        
	#              
	# parameters:
	# conn - connection object to the node
	# url - URL for the POST request
	# hdr - header paramters for the POST request
	# params - JSON body for POST request
	#                                                    
	# return: JSON response
	def self.post(conn, url, hdr, params)
		begin
                        resp = RestClient::Request.execute method: :post, url: url, headers: hdr, payload: params, user: conn.getUser, password: conn.getPassword, timeout: 20 ,:verify_ssl => false
                        response = JSON.parse(resp)
                        response
		rescue RestClient::ExceptionWithResponse => err
                        puts err
			puts err.response.match(/<p>(.+)<\/p>/)[1]


                end	
	end
	
	# This API performs DELETE request for the given url and switch connection.
	#        
	#              
	# parameters:
	# conn - connection object to the node
	# url - URL for the DELETE request
	# hdr - header paramters for the DELETE request
	#                                                    
	# return: JSON response
	def self.delete(conn, url, hdr)
		begin
                        resp = RestClient::Request.execute method: :delete, url: url, headers: hdr, user: conn.getUser, password: conn.getPassword, timeout: 20 ,:verify_ssl => false
                rescue RestClient::ExceptionWithResponse => err
                        puts err
			puts err.response.match(/<p>(.+)<\/p>/)[1]

                end

	end

end
