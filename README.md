# Lenovo CNOS Ruby API Library

## Overview
The Ruby Client for CNOS API provides a native Ruby implementation for programming
Lenovo CNOS network devices using Ruby.  The Ruby client provides the ability to
build native applications in Ruby that can communicate with CNOS remotely over 
a HTTP/S transport (off-box).

The Ruby API implemenation also provides an API layer for building native Ruby
objects that allow for configuration and management of Lenovo CNOS switches. 

The library is freely provided to the open source community for building applications 
using CNOS REST API infrastrcuture. Support is provided as best effort through
Github iusses.

## Requirements
* Lenovo CNOS 10.4 or later
* Ruby 2.2.3 or later

## CNOS Ruby APIs
The CNOS Ruby Client was designed to be easy to use and develop plugins or tools
that interface with the Lenovo CNOS switches.

### Using the API
#### Switch Configuration file
This configuration file is used to define the configuration options or model for switches (switch.yml or any xxx.yml)
```yaml
transport : 'http' # transport (HTTP/HTTPs)
port : '8090' # HTTP(s) port number (8090 - HTTP, 443 - HTTPs)
ip : 'switch ip address' # Switch IP address
user : 'username'  # Switch Credentials
password : 'password' #switch credentials 
```
#### Creating connection and sending configurations
Below demonstrates a basic connection using the API. For more examples, please see the examples folder.
```ruby
#import the libraries
require 'cnos-rbapi/connect'
require 'cnos-rbapi/vlan'

##### create connection to the node using the configuration file
conn = Connect.new(param) 

where param is a dictionary formed either from the config file or hardcoded 
with the following key value pairs 

transport => 'http' # transport (HTTP/HTTPs) 
port => '8090' # HTTP(s) port number (8090 - HTTP, 443 - HTTPs)
ip => 'switch ip address' # Switch IP address 
user => 'username' #Switch Credentials
password => 'password' #Switch Credentials
  
##### Use VLAN APIs to retrieve VLAN information
Vlan.get_all_vlan(conn)
params = {"vlan_name" => "test", "vlan_id" => 10, "admin_state" => "up"}

##### Use VLAN APIs to create/update and delete VLANs
resp = Vlan.create_vlan(conn, params) 

resp = Vlan.get_vlan_prop(conn, 10)

params = {"vlan_name" => "test", "admin_state" => "up"}

resp = Vlan.update_vlan(conn, 10, params)

Vlan.delete_vlan(conn, 10)
```
