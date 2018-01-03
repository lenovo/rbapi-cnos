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
require 'yaml'

def form_hdr(conn)
	hdr = {}
	tmp_ckie = 'auth_cookie='+ conn.getCookie + ';user=' + conn.getUser + '; Max-Age=3600; Path=/'
   	hdr['Cookie'] = tmp_ckie
   	hdr['Content-type'] = 'application/json'
   	return hdr
end	

def form_url(conn, url)
	url = conn.getTransport +  '://' + conn.getIp + ':' + conn.getPort + url
	return url
end

##
## The Connect class provides a class implementation and methods for establishing node connections and
## initializations. This class presents an abstraction
## 

class Connect
	
	# This function is used to initialise node paramters and establish connection with the given paramters.
        # 
        # 
        #  parameters:
        #  file   :config file
        #
        #  return: Connect object 		
	def initialize(params)
		@transport = params['transport']
		@port      = params['port']
		@ip        = params['ip']
		@user      = params['user']
		@password  = params['password']
		@cookie    = ''
                if @transport == 'http'
			@url       = @transport + '://' + @ip + ':' + @port + '/nos/api/login/'
                end
                if @transport == 'https'
			@url       = @transport + '://' + @ip + '/nos/api/login/'
                end
		
		begin
			RestClient::Request.execute(method: :get, url: @url, user: @user, password: @password, timeout: 10, :verify_ssl => false)
		rescue RestClient::Unauthorized, RestClient::Forbidden => err
  			@cookie =  err.response.cookies['auth_cookie']
		end
		
		@hdr = {}
		tmp_ckie = 'auth_cookie=' + @cookie + ';user=' + @user + '; Max-Age=3600; Path=/'
		@hdr['Cookie'] = tmp_ckie
		resp = RestClient::Request.execute(method: :get, url: @url, headers: @hdr, user: @user, password: @password, timeout: 10, :verify_ssl => false)
		@cookie = resp.cookies['auth_cookie']
		@hdr['Content-type'] = 'application/json'

	end


	# This API returns Transport protocol for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: transport - string	
	def getTransport()
		return @transport
	end

	# This API returns Port for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: port - string	
	def getPort()
                return @port
	end
	
	# This API returns IP  for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: IP	- string
	def getIp()
                return @ip
	end
	
	# This API returns User for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: User	- string 
	def getUser()
		return @user
	end
	
	# This API returns Password for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: Password - string	
	def getPassword()
                return @password
	end
	
	# This API returns Cookie for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: Cookie - string
	def getCookie()
                return @cookie
	end

	# This API returns Header Info for the current node connection.
        # 
        # 
        #  parameters:
        #
        #  return: header - string	
	def getHdr()
		return @hdr
	end


end
