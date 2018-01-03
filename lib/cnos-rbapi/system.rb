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
## The System class provides a class implementation and methods for managing and setting up
## images and config files on the node. This class presents an abstraction
##


class System
	
	@cfg  = '/nos/api'
        # This API downloads a boot image to the switch
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "protocol":"<protocol>",
        #  		  "serverip":"<serverip>",
        #  		  "srcfile":"<srcfile>",
        #  		  "imgtype":"<imgtype>",
        #  		  "username":"<username>",
        #  		  "passwd":"<passwd>",
        #  		  "vrf_name":"<vrf_name>"
        #  		} 
        #  description -
        #  protocol :Protocol name; one of ʺtftpʺ, ʺsftpʺ.
        #  serverip :Server IP address.
        #  srcfile  :Source file; up to 256 characters long.
        #  imgtype  :System image type; one of ʺallʺ, ʺbootʺ, ʺonieʺ, ʺosʺ.
        #  username :Username for the server. Not required for TFTP.
        #  passwd   :Password for the server username. Not required for TFTP.
        #  vrf_name :(Optional) VRF name; an alphabetic string up to 64 characters long
        # 
        #  return: JSON response
	def self.download_boot_img(conn, params)
		temp = @cfg + '/download/image'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.post(conn, url, hdr, params)
        end
        
	# This API updates the system startup image
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #    		  “boot software” : “<setting>”
        # 		}
        #  description -
        #  setting :Next startup image setting; one of “active” or “standby”
        #  
        #  return: JSON response 		
        def self.put_startup_sw(conn, params)
                temp = @cfg + '/startup/software'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.put(conn, url, hdr, params)
        end
	
	# This API gets the system startup image.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_startup_sw(conn)
		temp = @cfg + '/startup/software'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API resets the switch
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.reset_switch(conn)
                temp = @cfg + '/reset'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	
	# This API downloads a configuration to the switch
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "protocol":"<protocol>",
        #  		  "serverip":"<serverip>",
        #  		  "srcfile":"<srcfile>",
        #  		  "dstfile":"<dstfile>",
        #  		  "username":"<username>",
        #  		  "passwd":"<passwd>",
        #  		  "vrf_name":"<vrf_name>"
        #  		}
        #  description -
        #  protocol :Protocol name; one of ʺtftpʺ, ʺsftpʺ.
        #  serverip :Server IP address.
        #  srcfile  :Source file; up to 256 characters long.
        #  dstfile  :Destination file; one of 'running_config', 'startup_config'.
        #  username :(Optional) Username for the server.
        #  passwd   :(Optional) Password for the server username.
        #  vrf_name :(Optional) VRF name; an alphabetic string up to 64 characters long
        #
        #  return: JSON response 			
	def self.download_sw_config(conn, params)
                temp = @cfg + '/download/config'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)
        end
	
	# This API saves the running configuration to the flash memory
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 			
	def self.save_config(conn)
                temp = @cfg + '/save/config'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API uploads a configuration file from the switch to the server
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "protocol":"<protocol>",
        #  		  "serverip":"<serverip>",
        #  		  "srcfile":"<srcfile>",
        #  		  "dstfile":"<dstfile>",
        #  		  "username":"<username>",
        #  		  "passwd":"<passwd>",
        #  		  "vrf_name":"<vrf_name>"
        #  		}
        #  description -
        #  protocol :Protocol name; one of ʺtftpʺ, ʺsftpʺ.
        #  serverip :Server IP address.
        #  srcfile  :Source file; up to 256 characters long.
        #  dstfile  :Destination file; one of 'running_config', 'startup_config'.
        #  username :(Optional) Username for the server.
        #  passwd   :(Optional) Password for the server username.
        #  vrf_name :(Optional) VRF name; an alphabetic string up to 64 characters long
        #
        #  return: JSON response 			
	def self.upload_sw_config(conn, params)
                temp = @cfg + '/upload/config'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)
        end
        
	# This API uploads technical support information from the switch to the server
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #  		{
        #  		  "protocol":"<protocol>",
        #  		  "serverip":"<serverip>",
        #  		  "dstfile":"<dstfile>",
        #  		  "username":"<username>",
        #  		  "passwd":"<passwd>",
        #  		  "vrf_name":"<vrf_name>"
        #  		}
        #  description -
        #  protocol :Protocol name; one of ʺtftpʺ, ʺsftpʺ.
        #  serverip :Server IP address.
        #  dstfile  :Destination file; one of 'running_config', 'startup_config'.
        #  username :(Optional) Username for the server.
        #  passwd   :(Optional) Password for the server username.
        #  vrf_name :(Optional) VRF name; an alphabetic string up to 64 characters long
        #
        #  return: JSON response 		
	def self.upload_tech_support(conn, params)
                temp = @cfg + '/upload/tech_support'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.post(conn, url, hdr, params)
        end

	# This API gets the status of a downloading transfer.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  content - One of 'image', 'running_config', 'startup_config'
        #  type - 'upload' or 'download'
        #
        #  return: JSON response 		
	def self.get_transfer_status(conn, type, content)
                temp = @cfg + '/' + type + '/status/' + content
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API gets the hostname of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_hostname(conn)
                temp = @cfg + '/cfg/hostname'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end
	
	# This API sets the system boot image.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                      "hostname":"<hostname>"
        #                  }
        #  description - 
        #  hostname :The hostname of the system; a string from 1‐64 characters long                    
        #
        #  return: JSON response 		
	def self.set_hostname(conn, params)
                temp = @cfg + '/cfg/hostname'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
		params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API gets the date of the system
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response 		
	def self.get_clock(conn)
                temp = @cfg + '/cfg/clock'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API sets the system date.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                    	"time": "<HH:MM:SS>" ,
        #                    	"day": <day>,
        #                    	"month": <month> ,
        #                    	"year": <year>
        #                  }
        #  description - 
        #  time  :System time in the format ʺHH:MM:SSʺ.
        #  day   :The day of the month; an integer from 1‐31.
        #  month :The month; one of the following case‐insensitive strings:
        #   January
        #   February
        #   March
        #   April
        #   May
        #   June
        #   July
        #   August
        #   September
        #   October
        #   November
        #   December
        #  year  :The year; an integer from 2000‐2030.
        #
        #  return: JSON response 		
        def self.set_clock(conn, params)
                temp = @cfg + '/cfg/clock'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API sets the clock format to 12 hour or 24 hour format.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	 "format": <format>
        #                  }
        #  description - 
        #  format :System clock format; one of:
        #   		12 (12 hour format)
        #   		24 (24 hour format)
        #
        #   return: JSON response                
	def self.set_clock_format(conn, params)
                temp = @cfg + '/cfg/clock/format/'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API sets the protocol to either manual or Network Time Protocol.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	 "protocol": "<protocol>"
        #                  }
        # description -
        # protocol :System clock protocol; one of:
        #           none ‐ the clock is manually configured
        #           ntp ‐ the clock is configured through NTP
        # 	    Default value: “ntp”. 
        #
	# return: JSON response
	def self.set_clock_protocol(conn, params)
                temp = @cfg + '/cfg/clock/protocol/'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API sets the clock time zone for the switch
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	 ""timezone": "<timezone>",
        #                  	  "offsethour": "<offsethour>",
        #                  	  "offsetmin": "<lag_mode>",
        #                  }
        # description -
        # timezone   :One to five letter string denoting the local system time zone.
        # offsethour :Hours offset from UTC; an integer from ‐23 through 23.
        # offsetmin  :Minutes offset from UTC; an integer from 0‐59. 
        #
	# return: JSON response          
	def self.set_clock_timezone(conn, params)
                temp = @cfg + '/cfg/clock/timezone/'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end
	
	# This API gets the device contact.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response
	def self.get_device_contact(conn)
                temp = @cfg + '/cfg/contact'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the device contact.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	  "contact": <contact>
        #                  }
        #  description - 
        #  contact   :Device contact; a string up to 256 characters long
        #
        #  return: JSON response
        def self.set_device_contact(conn, params)
                temp = @cfg + '/cfg/contact'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API gets the device descr.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #
        #  return: JSON response
	def self.get_device_descr(conn)
                temp = @cfg + '/cfg/descr'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                Rest.get(conn, url, hdr)
        end

	# This API updates the device description.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	  "descr": <descr>
        #                  }
        #  description - 
        #  descr   :Device description; a string up to 256 characters long.
        #
        #  return: JSON response
        def self.set_device_descr(conn, params)
                temp = @cfg + '/cfg/descr'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end

	# This API set the transition to and from a summer time zone adjustment.
        # 
        # 
        #  parameters:
        #  conn - connection object to the node
        #  params - dictionary that requires the following format of key-value pairs
        #                  {
        #                  	  "timezone": <time_zone>,
        #                  	  "startweek": <start_week>,
        #                  	  "startweekday": <start_weekday>,
        #                  	  "startmonth": <start_month>,
        #                  	  "starttime" :  "<HH:MM>",
        #                  	  "endweek"   : <end_week>,
        #                  	  "endweekday": <end_weekday>,
        #                  	  "endmonth"  : <end_month>,
        #                  	  "endtime"   :  “<HH:MM>”,
        #                  	  "offsetmin" : <minutes>
        #                  }
        #  description -
        #  timezone     :Local time zone of the system; a three to five character
        #  		 string such as ʺPSTʺ, ʺMSTʺ, ʺCSTʺ, or ʺESTʺ.
        #  startweek    :Week number in the month in which to start Daylight
        #  		 Saving time; an integer from 1‐5 (first week=1, last
        #  		 week=5).
        #  startweekday :Weekday on which to start DST; one of the following
        #  		 case‐insensitive strings:
        #   		 monday - sunday
        #  startmonth   :Month to start DST; one of the following
        #   		 case‐insensitive strings:
        #   		 january - december
        #  starttime    :Time to start DST; a string in the format ʺHH:MMʺ.
        #   		 endweek Week number in which to end DST; an integer from
        #                1‐5 (first week=1, last week=5).
        #  endweekday   :Weekday on which to end DST; one of the following
        #   	         case‐insensitive strings:
        #   		 monday - sunday
        #  endmonth     :Month in which DST ends; one of the following
        # 	         case‐insensitive strings:
        #   		 january - december
        #  endtime      :Time to end DST; a string in the format ʺHH:MMʺ
        #  offsetmin    :Offset to add, in minutes; an integer from 1‐1440.
        #
	#  return: JSON response
	def self.set_clock_summertime(conn, params)
                temp = @cfg + '/cfg/clock/summertime'
                url = form_url(conn, temp)
                hdr = form_hdr(conn)
                params = params.to_json
                Rest.put(conn, url, hdr, params)
        end


end
