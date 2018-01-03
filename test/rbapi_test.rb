
require 'cnos-rbapi'
require 'cnos-rbapi/vlan'
require 'cnos-rbapi/vlan_intf'
require 'cnos-rbapi/lag'
require 'cnos-rbapi/arp'
require 'cnos-rbapi/lldp'
require 'cnos-rbapi/lacp'
require 'cnos-rbapi/vlag'
require 'cnos-rbapi/telemetry'
require 'cnos-rbapi/vrrp'
require 'cnos-rbapi/mstp'
require 'cnos-rbapi/ip_intf'
require 'cnos-rbapi/system'
require 'cnos-rbapi/igmp'
require 'cnos-rbapi/stp'
require 'yaml'
require 'json'

config = ["mars.yml", "jupiter.yml", "neptune.yml", "voyager.yml"]
file = File.open("/tmp/test_log.txt", "w")
 
config.each do |line|
        file.puts("\n\n                                                                      " +  line + "\n\n")
        params = YAML.load_file(line)
        conn = Connect.new(params)
        resp = Vlan.get_all_vlan(conn)
	if resp == nil
	 file.puts( "CH_LEN_088 - get_all_vlan -------->FAILED\n")
	else
	 file.puts( "CH_LEN_088 - get_all_vlan -------->PASSED\n")
	end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"vlan_name" => "test", "vlan_id" => 10, "admin_state" => "up"}
	resp = Vlan.create_vlan(conn, params)	
	if resp == nil
	 file.puts( "CH_LEN_089 - create_vlan -------->FAILED\n")
	else
	 file.puts( "CH_LEN_089 - create_vlan -------->PASSED\n")
	end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlan.get_vlan_prop(conn, 10)
	if resp == nil
	 file.puts( "CH_LEN_090 get_vlan_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_090 get_vlan_prop -------->PASSED\n")
	end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"vlan_name" => "testagain", "admin_state" => "up"}
	resp = Vlan.update_vlan(conn, 10, params)
	if resp == nil
	 file.puts( "CH_LEN_092 - update_vlan -------->FAILED\n")
	else
         if resp['vlan_name'] == "testagain"
                file.puts( "CH_LEN_092 - update_vlan -------->PASSED\n")
         else
                file.puts( "CH_LEN_092 - update_vlan -------->FAILED\n")
         end
	end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlan.delete_vlan(conn, 10)
        resp = Vlan.get_vlan_prop(conn, 10)
	if resp == nil
	 file.puts( "CH_LEN_091 - delete_vlan -------->PASSED\n")
	else
         file.puts( "CH_LEN_091 - delete_vlan -------->FAILED \n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        

###########################################################################

        file.puts( "\n testing vlan_intf.rb \n\n")
        resp = VlanIntf.get_all_vlan_intf(conn)
	if resp == nil
	 file.puts( "CH_LEN_093 get_all_vlan_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_093 get_all_vlan_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        resp = VlanIntf.get_vlan_prop_intf(conn, 'Ethernet1/2')
	if resp == nil
	 file.puts( "CH_LEN_094 get_vlan_prop_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_094 get_vlan_prop_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"pvid"=>1, "vlans"=>[1], "bridgeport_mode"=>"access", "if_name"=>"Ethernet1/92"}
        VlanIntf.update_vlan_intf(conn, 'Ethernet1/2', params)
	if resp == nil
	 file.puts( "CH_LEN_095 update_vlan_intf -------->FAILED\n")
	else
         if resp['bridgeport_mode'] == "access"
                file.puts( "CH_LEN_095 update_vlan_intf -------->PASSED\n")
         else
                file.puts( "CH_LEN_095 update_vlan_intf -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

##########################################################################
        
        file.puts( "\n testing lag.rb \n\n")
        resp = Lag.get_all_lag(conn)
	if resp == nil
	 file.puts( "CH_LEN_007 get_all_lag -------->FAILED\n")
	else
	 file.puts( "CH_LEN_007 get_all_lag -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        resp = Lag.create_lag(conn, 25)
	if resp == nil
	 file.puts( "CH_LEN_001 create_lag -------->FAILED\n")
	else
	 file.puts( "CH_LEN_001 create_lag -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        resp = Lag.get_lag_prop(conn, 25)
	if resp == nil
	 file.puts( "CH_LEN_006 get_lag_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_006 get_lag_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        resp = Lag.get_load_balance(conn)
	if resp == nil
	 file.puts( "CH_LEN_004 get_load_balance -------->FAILED\n")
	else
	 file.puts( "CH_LEN_004 get_load_balance -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"interfaces"=> [], "lag_id"=> 25, "min_links"=> 2} 
        resp = Lag.update_lag(conn, 25, params)
	if resp == nil
	 file.puts( "CH_LEN_003 update_lag-------->FAILED\n")
	else
         if resp['min_links'] == 2
                file.puts( "CH_LEN_003 update_lag-------->PASSED\n")
         else
                file.puts( "CH_LEN_003 update_lag-------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { "destination-port" => "no"}
        resp = Lag.update_lag_load_balance(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_005 update_lag_load_balance -------->FAILED\n")
	else
         if resp['destination-port'] == "no"
                file.puts( "CH_LEN_005 update_lag_load_balance -------->PASSED\n")
         else
                file.puts( "CH_LEN_005 update_lag_load_balance -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        Lag.delete_lag(conn, 25)
        resp = Lag.get_lag_prop(conn, 25)
	if resp == nil
	 file.puts( "CH_LEN_002 delete_lag -------->PASSED\n")
	else
	 file.puts( "CH_LEN_002 delete_lag -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

#########################################################################

        file.puts( "\n testing arp.rb \n\n")
	resp = Arp.get_arp_sys_prop(conn)
	if resp == nil
	 file.puts( "CH_LEN_061 get_arp_sys_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_061 get_arp_sys_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Arp.get_arp_prop_all(conn)
	if resp == nil
	 file.puts( "CH_LEN_115 get_arp_prop_all -------->FAILED\n")
	else
	 file.puts( "CH_LEN_115 get_arp_prop_all -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"ageout_time"=>100}
	resp = Arp.set_arp_sys_prop(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_062 set_arp_sys_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_062 set_arp_sys_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Arp.get_arp_intf_prop(conn, 'Ethernet1/1')
	if resp == nil
	 file.puts( "CH_LEN_063 get_arp_intf_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_063 get_arp_intf_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"ageout_time"=> 70, "if_name"=>"Ethernet1/1"}
	resp = Arp.set_arp_intf_prop(conn, 'Ethernet1/1', params)
	if resp == nil
	 file.puts( "CH_LEN_064 set_arp_intf_prop -------->FAILED\n")
	else
         if resp['ageout_time'] == 70
	 	file.puts( "CH_LEN_064 set_arp_intf_prop -------->PASSED\n")
         else    
	 	file.puts( "CH_LEN_064 set_arp_intf_prop -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")


####################################################################
        
        file.puts( "\n testing lldp.rb \n\n")
	resp = Lldp.get_lldp_prop(conn)
	if resp == nil
	 file.puts( "CH_LEN_069 get_lldp_prop -------->FAILED\n")
	else
	 file.puts( "CH_LEN_069 get_lldp_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Lldp.get_lldp_all_intf(conn)
	if resp == nil
	 file.puts( "CH_LEN_071 get_lldp_all_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_071 get_lldp_all_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Lldp.get_lldp_intf(conn, 'Ethernet1/1')
	if resp == nil
	 file.puts( "CH_LEN_072 get_lldp_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_072 get_lldp_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Lldp.get_lldp_intf_stats(conn, 'Ethernet1/1')
	if resp == nil
	 file.puts( "CH_LEN_116 get_lldp_intf_stats -------->FAILED\n")
	else
	 file.puts( "CH_LEN_116 get_lldp_intf_stats -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Lldp.get_lldp_intf_neighbor(conn, 'Ethernet1/3')
	if resp == nil
	 file.puts( "CH_LEN_117 get_lldp_intf_neighbour -------->FAILED\n")
	else
	 file.puts( "CH_LEN_117 get_lldp_intf_neighbour -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Lldp.get_lldp_intf_neighbor_all(conn)
	if resp == nil
	 file.puts( "CH_LEN_118 get_lldp_intf_neighbour_all -------->FAILED\n")
	else
	 file.puts( "CH_LEN_118 get_lldp_intf_neighbour_all -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"transmit interval": 35, "transmit delay": 2, "reinit delay": 3}
	resp = Lldp.update_lldp_prop(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_070 update_lldp_prop -------->FAILED\n")
	else
         if resp['reinit delay'] == 3
	 	file.puts( "CH_LEN_070 update_lldp_prop -------->PASSED\n")
         else    
	 	file.puts( "CH_LEN_070 update_lldp_prop -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"ena_lldp_rx": "yes", "if_name": "Ethernet1/3", "ena_lldp_tx": "yes"}
	resp = Lldp.update_lldp_intf(conn, 'Ethernet1/3', params)
	if resp == nil
	 file.puts( "CH_LEN_073 update_lldp_intf -------->FAILED\n")
	else
         if resp['ena_lldp_tx'] == 'yes'
	 	file.puts( "CH_LEN_073 update_lldp_intf -------->PASSED\n")
         else    
	 	file.puts( "CH_LEN_073 update_lldp_intf -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

        file.puts( "\n testing lacp.rb \n\n")
	resp = Lacp.get_lacp(conn)
	if resp == nil
	 file.puts( "CH_LEN_074 get_lacp -------->FAILED\n")
	else
	 file.puts( "CH_LEN_074 get_lacp -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"sys_prio" => 32767}
	resp = Lacp.update_lacp(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_075 update_lacp -------->FAILED\n")
	else
         if resp['sys_prio'] == 32767
	 	file.puts( "CH_LEN_075 update_lacp -------->PASSED\n")
         else    
	 	file.puts( "CH_LEN_075 update_lacp -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

##################################################################
        
        file.puts( "\n testing ip_intf.rb \n\n")
	resp = Ipintf.get_ip_prop_all(conn)
	if resp == nil
	 file.puts("CH_LEN_076 get_ip_prop_all -------->FAILED\n")
	else
	 file.puts("CH_LEN_076 get_ip_prop_all -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Ipintf.get_ip_prop_intf(conn,'Ethernet1/1')
	if resp == nil
	 file.puts("CH_LEN_077  get_ip_prop_intf -------->FAILED\n")
	else
	 file.puts("CH_LEN_077  get_ip_prop_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { "ip_addr": "1.1.1.1", "bridge_port": "no", "if_name": "Ethernet1/1", "mtu": 1500, "vrf_name": "default", "admin_state": "up", "ip_prefix_len": 24}
        resp = Ipintf.update_ip_prop_intf(conn, 'Ethernet1/1', params)
	if resp == nil
	 file.puts("CH_LEN_078 update_ip_prop_intf -------->FAILED\n")
	else
         if resp['bridge_port'] == "no"
                file.puts( "CH_LEN_078 - update_ip_prop_intf -------->PASSED\n")
         else
                file.puts( "CH_LEN_078 - update_ip_prop_intf -------->FAILED\n")
         end
       end
       file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

########################################################################
       
        file.puts( "\n testing vrrp.rb \n\n")
	resp = Vrrp.get_vrrp_prop_all(conn)
	if resp == nil
	 file.puts( "CH_LEN_032 get_vrrp_prop_all -------->FAILED\n")
	else
	 file.puts( "CH_LEN_032 get_vrrp_prop_all -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vrrp.get_vrrp_intf(conn, 'Ethernet1/1')
	if resp == nil
	 file.puts( "CH_LEN_033 get_vrrp_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_033 get_vrrp_intf_stats -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {
		"if_name":"Ethernet1/1",
		"vr_id":1,
		"ip_addr":"1.1.1.254",
		"ad_intvl":100,
		"preempt":"no",
		"prio":100,
		"admin_state":"down",
		"accept_mode":"no",
		"switch_back_delay":1,
		"v2_compt":"no"
	}
	resp = Vrrp.create_vrrp_intf(conn, 'Ethernet1/1', params)
	if resp == nil
	 file.puts( "CH_LEN_035 create_vrrp_intf_vrid -------->FAILED\n")
	else
	 file.puts( "CH_LEN_035 create_vrrp_intf_vrid -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {
		"if_name":"Ethernet1/1",
		"vr_id":1,
		"ip_addr":"1.1.1.254",
		"ad_intvl":100,
		"preempt":"no",
		"prio":100,
		"admin_state":"up",
		"accept_mode":"no",
		"switch_back_delay":1,
		"v2_compt":"no"
	}
	resp = Vrrp.update_vrrp_intf_vrid(conn, 'Ethernet1/1', 1, params)
	if resp == nil
	 file.puts( "CH_LEN_036 update_vrrp_intf_vrid -------->FAILED\n")
	else
         if resp['admin_state'] == "up"
	 	file.puts( "CH_LEN_036 update_vrrp_intf_vrid -------->PASSED\n")
         else    
	 	file.puts( "CH_LEN_036 update_vrrp_intf_vrid -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vrrp.del_vrrp_intf_vrid(conn, 'Ethernet1/1', 1)
        resp = Vrrp.get_vrrp_intf_vrid(conn, 'Ethernet1/1' , 1)
	if resp == []
	 file.puts( "delete_vrrp_intf_vrid -------->PASSED\n")
	else
	 file.puts( "delete_vrrp_intf_vrid -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

##################################################################

        file.puts( "\n testing vlag.rb \n\n")
	resp = Vlag.get_vlag_conf(conn)
	if resp == nil
	 file.puts( "CH_LEN_020 get_vlag_conf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_020 get_vlag_conf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlag.get_global_vlag(conn)
	if resp == nil
	 file.puts( "CH_LEN_022 get_global_vlag -------->FAILED\n")
	else
	 file.puts( "CH_LEN_022 get_global_vlag -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlag.get_vlag_isl(conn)
	if resp == nil
	 file.puts( "CH_LEN_023 get_vlag_isl -------->FAILED\n")
	else
	 file.puts( "CH_LEN_023 get_vlag_isl -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlag.get_vlag_health(conn)
	if resp == nil
	 file.puts( "CH_LEN_025 get_vlag_health -------->FAILED\n")
	else
	 file.puts( "CH_LEN_025 get_vlag_health -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        resp = Vlag.get_vlag_inst_info(conn, 2)
	if resp == nil
	 file.puts( "CH_LEN_031 get_vlag_inst_info -------->FAILED\n")
	else
	 file.puts( "CH_LEN_031 get_vlag_inst_info -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Vlag.get_vlag_inst_confg(conn, 2)
        if resp == nil
	 file.puts( "CH_LEN_030 get_vlag_inst_confg -------->FAILED\n")
	else
	 file.puts( "CH_LEN_030 get_vlag_inst_confg -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"priority": 0, "auto_recovery": 300, "startup_delay": 120, "tier_id": 11, "status": "disable"}
        resp = Vlag.update_vlag_conf(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_021 update_vlag_conf -------->FAILED\n")
	else
         if resp['auto_recovery'] == 300
                file.puts( "CH_LEN_021 update_vlag_conf -------->PASSED\n")
         else
                file.puts( "CH_LEN_021 update_vlag_conf -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {"port_aggregator": 200}
	resp = Vlag.update_vlag_isl(conn, params)
        resp = Vlag.get_vlag_isl(conn)
	if resp == nil
	 file.puts( "CH_LEN_024 update_vlag_isl -------->FAILED\n")
	else
         if resp['port_aggregator'] == 200
                file.puts( "CH_LEN_024 update_vlag_isl -------->PASSED\n")
         else
                file.puts( "CH_LEN_024 update_vlag_isl -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = { "keepalive_interval": 5, "retry_interval": 30, "peer_ip": "10.240.177.120", "vrf": "default", "keepalive_attempts": 3}
	resp = Vlag.update_vlag_health(conn, params)
	if resp == nil
	 file.puts( "CH_LEN_026 update_vlag_health -------->FAILED\n")
	else
         if resp['keepalive_interval'] == 5
                file.puts( "CH_LEN_026 update_vlag_health -------->PASSED\n")
         else
                file.puts( "CH_LEN_026 update_vlag_health -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"port_aggregator": 2, "status": "disable", "inst_id": 1}
	resp = Vlag.create_vlag_inst(conn, params)
        resp = Vlag.get_vlag_inst_confg(conn, 1)
        if resp == nil
	 file.puts( "CH_LEN_027 create_vlag_inst -------->FAILED\n")
	else
         if resp['status'] == 'disable'
	  file.puts( "CH_LEN_027 create_vlag_inst -------->PASSED\n")
         else 
	  file.puts( "CH_LEN_027 create_vlag_inst -------->FAILED\n")
         end

        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"status": "enable"}
        resp = Vlag.update_vlag_inst(conn, 1, params)
        resp = Vlag.get_vlag_inst_confg(conn, 1)
	if resp == nil
	 file.puts( "CH_LEN_028 update_vlag_inst -------->FAILED\n")
	else
         if resp['status'] == 'enable'
                file.puts( "CH_LEN_028 update_vlag_inst -------->PASSED\n")
         else
                file.puts( "CH_LEN_028 update_vlag_inst -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        Vlag.delete_vlag_inst(conn, 1)
        resp = Vlag.get_vlag_inst_confg(conn, 1)
	if resp == nil
	 file.puts( "CH_LEN_029 delete_vlag_inst -------->PASSED\n")
	else
         if resp['port_aggregator'] == 0
	  file.puts( "CH_LEN_029 delete_vlag_inst -------->PASSED\n")
         else 
	  file.puts( "CH_LEN_029 delete_vlag_inst -------->FAILED\n")
         end
        end

###################################################################

	params = {"vlan_name" => "test", "vlan_id" => 10, "admin_state" => "up"}
	resp = Vlan.create_vlan(conn, params)	
	file.puts( "\n testing mstp.rb \n\n")
	resp = Mstp.get_mstp_sys_prop(conn)
	if resp == nil
	 file.puts("CH_LEN_011 get_mstp_sys_prop -------->FAILED\n")
	else
	 file.puts("CH_LEN_011 get_mstp_sys_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	params = {'region_name' => 'test', 'revision' => 1}
	resp = Mstp.update_mstp_sys_prop(conn, params)
	if resp == nil
	 file.puts("CH_LEN_012 update_mstp_sys_prop -------->FAILED\n")
	else
         if resp['region_name'] == 'test'
	 	file.puts("CH_LEN_012 update_mstp_sys_prop -------->PASSED\n")
         else
                file.puts("CH_LEN_012 update_mstp_sys_prop -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Mstp.get_mstp_inst_all(conn)
	if resp == nil
	 file.puts( "CH_LEN_013 get_mstp_all -------->FAILED\n")
	else
	 file.puts( "CH_LEN_013 get_mst_all -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"instance_id": 1, "vlans": [{"vlan_id": 10}], "instance_prio": 32768}
        Mstp.create_mstp_inst(conn,params)
        resp = Mstp.get_mstp_inst(conn, 1)
        if resp == nil
         file.puts( "CH_LEN_014 create_mstp_inst -------->FAILED\n")
        else
         file.puts( "CH_LEN_014 create_mstp_inst -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Mstp.get_mstp_inst(conn, 0)
	if resp == nil
	 file.puts( "CH_LEN_015 get_mstp_inst -------->FAILED\n")
	else
	 file.puts( "CH_LEN_015 get_mstp_inst -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = [{"instance_id": 0, "vlans": [{"vlan_id": 1}], "instance_prio": 3276}]
	resp = Mstp.update_mstp_inst(conn, 0, params)
    resp = Mstp.get_mstp_inst(conn, 0)
	if resp == nil
	 file.puts( "CH_LEN_016 update_mstp_inst -------->FAILED\n")
	else
         if resp[0]['instance_prio'] == 3276
	 	file.puts("CH_LEN_016 update_mstp_inst -------->PASSED\n")
         else
                file.puts("CH_LEN_016 update_mstp_inst -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Mstp.del_mstp_inst(conn, 1)
	resp = Mstp.get_mstp_inst(conn, 1)
	if resp == nil
	 file.puts( "CH_LEN_017 del_mstp_inst -------->PASSED\n")
	else
	 file.puts( "CH_LEN_017 del_mstp_inst -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Mstp.get_mstp_inst_intf(conn, 0, "Ethernet1/1")
	if resp == nil
	 file.puts( "CH_LEN_018 get_mstp_inst_intf -------->FAILED\n")
	else
	 file.puts( "CH_LEN_018 get_mstp_inst_intf-------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"if_name": 'Ethernet1/1', "path_cost": 1, "port_prio": 128}
	resp = Mstp.update_mstp_inst_intf(conn, 1, 'Ethernet1/1', params)
    resp = Mstp.get_mstp_inst_intf(conn, 1,'Ethernet1/1')
	if resp == nil
	 file.puts( "CH_LEN_019 update_mstp_inst_intf -------->FAILED\n")
	else
         if resp['instance_prio'] == 3276
	 	file.puts("CH_LEN_019 update_mstp_inst_intf -------->PASSED\n")
         else
                file.puts("CH_LEN_019 update_mstp_inst_intf -------->FAILED\n")
         end
        end

#######################################################################3
       
        file.puts( "\n testing stp.rb \n\n")
	resp = Stp.get_all_stp(conn)
	if resp == nil
	 file.puts("CH_LEN_008 get_all_stp -------->FAILED\n")
	else
	 file.puts("CH_LEN_008 get_all_stp -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Stp.get_stp_intf(conn, 'Ethernet1/2')
	if resp == nil
	 file.puts("CH_LEN_009 get_stp_intf -------->FAILED\n")
	else
	 file.puts("CH_LEN_009 get_stp_intf -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"root_guard": "disable", "edge_port": "yes", "loop_guard": "disable", "if_name": "Ethernet1/2", "bpdu_guard": "disable"}
        resp = Stp.update_stp(conn, 'Ethernet1/2', params)
	if resp == nil
	 file.puts("CH_LEN_010 update_stp -------->FAILED\n")
	else
         if resp['edge_port'] == "yes"
                file.puts( "CH_LEN_010 - update_stp -------->PASSED\n")
         else
                file.puts( "CH_LEN_010 - update_stp -------->FAILED\n")
         end
       end
       file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
#########################################################################

        file.puts( "\n testing system.rb \n\n")
	resp = System.get_hostname(conn)
	if resp == nil
	 file.puts("CH_LEN_038 get_hostname -------->FAILED\n")
	else
	 file.puts("CH_LEN_038 get_hostname -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"hostname": "G8296"}
        resp = System.set_hostname(conn, params)
	if resp == nil
	 file.puts("CH_LEN_039 set_hostname -------->FAILED\n")
	else
         if resp['hostname'] == "G8296"
                file.puts( "CH_LEN_039 - set_hostname -------->PASSED\n")
         else
                file.puts( "CH_LEN_039 - set_hostname -------->FAILED\n")
         end
        end
        file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = System.get_clock(conn)
	if resp == nil
	 file.puts("CH_LEN_040 get_clock -------->FAILED\n")
	else
	 file.puts("CH_LEN_040 get_clock -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"time" => "12:23:23", "day"=> 3, "month" => "November", "year" => 2017}
        resp = System.set_clock(conn, params)
	if resp == nil
	 file.puts("CH_LEN_041 set_clock -------->FAILED\n")
	else
         file.puts( "CH_LEN_041 - set_clock -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"format": 12}
        resp = System.set_clock_format(conn, params)
	if resp == nil
	 file.puts("CH_LEN_042 set_clock_format -------->FAILED\n")
	else
         if resp['format'] == 12
                file.puts( "CH_LEN_042 - set_clock_format -------->PASSED\n")
         else
                file.puts( "CH_LEN_042 - set_clock_format -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"protocol": "ntp"}
        resp = System.set_clock_protocol(conn, params)
	if resp == nil
	 file.puts("CH_LEN_043 set_clock_protocol -------->FAILED\n")
	else
         if resp['protocol'] == "ntp"
                file.puts( "CH_LEN_043 - set_clock_protocol -------->PASSED\n")
         else
                file.puts( "CH_LEN_043 - set_clock_protocol -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"timezone" => "PST", "offsethour" => 10, "offsetmin" => 10}
        resp = System.set_clock_timezone(conn, params)
	if resp == nil
	 file.puts("CH_LEN_044 set_clock_timezone -------->FAILED\n")
	else
         file.puts( "CH_LEN_044 - set_clock_timezone -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = System.get_device_contact(conn)
	if resp == nil
	 file.puts("CH_LEN_045 get_device_contact -------->FAILED\n")
	else
	 file.puts("CH_LEN_045 get_device_contact -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"contact": "test"}
        resp = System.set_device_contact(conn, params)
	if resp == nil
	 file.puts("CH_LEN_046 set_device_contact -------->FAILED\n")
	else
         if resp['contact'] == "test"
                file.puts( "CH_LEN_046 - set_device_contact -------->PASSED\n")
         else
                file.puts( "CH_LEN_046 - set_device_contact -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"descr": "test"}
        resp = System.set_device_descr(conn, params)
	if resp == nil
	 file.puts("CH_LEN_047 set_device_descr -------->FAILED\n")
	else
         if resp['descr'] == "test"
                file.puts( "CH_LEN_047 - set_device_descr -------->PASSED\n")
         else
                file.puts( "CH_LEN_047 - set_device_descr -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = System.get_device_descr(conn)
	if resp == nil
	 file.puts("CH_LEN_120 get_device_descr -------->FAILED\n")
	else
	 file.puts("CH_LEN_120 get_device_descr -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

        file.puts( "\n testing igmp.rb \n\n")
	resp = Igmp.get_igmp_snoop_prop(conn)
	if resp == nil
	 file.puts("CH_LEN_065 get_igmp_snoop_prop -------->FAILED\n")
	else
	 file.puts("CH_LEN_065 get_igmp_snoop_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"ena_igmp_snoop": "yes"}
        resp = Igmp.set_igmp_snoop_prop(conn, params)
	if resp == nil
	 file.puts("CH_LEN_066 set_igmp_snoop_prop -------->FAILED\n")
	else
         if resp['ena_igmp_snoop'] == "yes"
                file.puts( "CH_LEN_066 - set_igmp_snoop_prop -------->PASSED\n")
         else
                file.puts( "CH_LEN_066 - set_igmp_snoop_prop -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Igmp.get_igmp_vlan_prop(conn, 1)
	if resp == nil
	 file.puts("CH_LEN_067 get_igmp_vlan_prop -------->FAILED\n")
	else
	 file.puts("CH_LEN_067 get_igmp_vlan_prop -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"fast_leave": "no", "query_interval": 120, "version": 3, "ena_igmp_snoop": "yes", "vlan_id": 1}
        resp = Igmp.set_igmp_vlan_prop(conn, 1 , params)
	if resp == nil
	 file.puts("CH_LEN_068 set_igmp_snoop_prop -------->FAILED\n")
	else
         if resp['query_interval'] == 120
                file.puts( "CH_LEN_068 - set_igmp_vlan_prop -------->PASSED\n")
         else
                file.puts( "CH_LEN_068 - set_igmp_vlan_prop -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

###########################################################################

        file.puts( "\n testing telemetry.rb \n\n")
	resp = Telemetry.get_sys_feature(conn)
	if resp == nil
	 file.puts("CH_LEN_049 get_sys_feature -------->FAILED\n")
	else
	 file.puts("CH_LEN_049 get_sys_feature -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"heartbeat-enable"=> 1, "msg-interval"=> 10}
        resp = Telemetry.set_sys_feature(conn, params)
	resp = Telemetry.get_sys_feature(conn)
	if resp == nil
	 file.puts("CH_LEN_050 set_sys_feature -------->FAILED\n")
	else
         if resp['msg-interval'] == 10
                file.puts( "CH_LEN_050 - set_sys_feature -------->PASSED\n")
         else
                file.puts( "CH_LEN_050 - set_sys_feature -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Telemetry.get_bst_tracking(conn)
	if resp == nil
	 file.puts("CH_LEN_051 get_bst_tracking -------->FAILED\n")
	else
	 file.puts("CH_LEN_051 get_bst_tracking -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"track-egress-port-service-pool"=> 1,
                  "track-egress-uc-queue"=> 1,
                  "track-egress-rqe-queue"=> 1,
                  "track-egress-cpu-queue"=> 1,
                  "track-ingress-port-service-pool"=> 1,
                  "track-ingress-service-pool"=> 1,
                  "track-egress-mc-queue"=> 1,
                  "track-peak-stats"=> 0,
                  "track-ingress-port-priority-group"=> 1,
                  "track-egress-service-pool"=> 1,
                  "track-device"=> 1}
        resp = Telemetry.set_bst_tracking(conn, params)
	resp = Telemetry.get_bst_tracking(conn)
	if resp == nil
	 file.puts("CH_LEN_052 set_bst_tracking -------->FAILED\n")
	else
         if resp['track-peak-stats'] == 0
                file.puts( "CH_LEN_052 - set_bst_tracking -------->PASSED\n")
         else
                file.puts( "CH_LEN_052 - set_bst_tracking -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Telemetry.get_bst_feature(conn)
	if resp == nil
	 file.puts("CH_LEN_053 get_bst_feature -------->FAILED\n")
	else
	 file.puts("CH_LEN_053 get_bst_feature -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
                  "collection-interval" => 60,
                  "send-async-reports"=> 0,
                  "send-snapshot-on-trigger"=> 1,
                  "trigger-rate-limit"=> 1,
                  "async-full-report"=> 0,
                  "trigger-rate-limit-interval"=> 10,
                  "bst-enable"=> 1}
	
        resp = Telemetry.set_bst_feature(conn, params)
	resp = Telemetry.get_bst_feature(conn)
	if resp == nil
	 file.puts("CH_LEN_054 set_bst_feature -------->FAILED\n")
	else
         if resp['bst-enable'] == 1
                file.puts( "CH_LEN_054 - set_bst_feature -------->PASSED\n")
         else
                file.puts( "CH_LEN_054 - set_bst_feature -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
	    "include-ingress-port-priority-group" => 1,
	    "include-ingress-port-service-pool" => 1,
	    "include-ingress-service-pool" => 1,
	    "include-egress-port-service-pool" => 1,
	    "include-egress-service-pool" => 1,
	    "include-egress-rqe-queue" => 1,
	    "include-device" => 1
         } 
	resp = Telemetry.get_bst_report(conn, params)
	if resp == nil
	 file.puts("CH_LEN_055 get_bst_report -------->FAILED\n")
	else
	 file.puts("CH_LEN_055 get_bst_report -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
	    "include-ingress-port-priority-group" => 1,
	    "include-ingress-port-service-pool" => 1,
	    "include-ingress-service-pool" => 1,
	    "include-egress-port-service-pool" => 1,
	    "include-egress-service-pool" => 1,
	    "include-egress-rqe-queue" => 1,
	    "include-device" => 1
               }
	resp = Telemetry.get_bst_threshold(conn, params)
	if resp == nil
	 file.puts("CH_LEN_056 get_bst_threshold -------->FAILED\n")
	else
	 file.puts("CH_LEN_056 get_bst_threshold -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"realm": "device", "threshold": 10} 
	resp = Telemetry.set_bst_threshold(conn, params)
        params = { 
	    "include-ingress-port-priority-group" => 0,
	    "include-ingress-port-service-pool" => 0,
	    "include-ingress-service-pool" => 0,
	    "include-egress-port-service-pool" => 0,
	    "include-egress-service-pool" => 0,
	    "include-egress-rqe-queue" => 0,
	    "include-device" => 1
               }
	resp = Telemetry.get_bst_threshold(conn, params)
	if resp['report'][0]['data'] == '10'
	 file.puts("CH_LEN_057 set_bst_threshold -------->PASSED\n")
	else
	 file.puts("CH_LEN_057 set_bst_threshold -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Telemetry.clear_bst_threshold(conn)
	if resp != nil
	 file.puts("CH_LEN_058 clear_bst_threshold -------->FAILED\n")
	else
	 file.puts("CH_LEN_058 clear_bst_threshold -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Telemetry.clear_bst_stats(conn)
	if resp != nil
	 file.puts("CH_LEN_059  clear_bst_stats -------->FAILED\n")
	else
	 file.puts("CH_LEN_059 clear_bst_stats -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = Telemetry.clear_bst_cgsn_ctrs(conn)
	if resp != nil
	 file.puts("CH_LEN_060 clear_bst_cgsn_ctrs -------->FAILED\n")
	else
	 file.puts("CH_LEN_060 clear_bst_cgsn_ctrs -------->PASSED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

#################################################################

        conf = line.dup
        conf = conf.split('.')[0]
        conf =  conf + '.conf'
        file.puts( "\n testing system.rb \n\n")
	resp = System.get_startup_sw(conn)
	if resp != nil
	 file.puts("CH_LEN_081 get_startup_sw -------->PASSED\n")
	else
	 file.puts("CH_LEN_081 get_startup_sw -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = {"boot software" => "active"}
        resp = System.put_startup_sw(conn, params)
	if resp == nil
	 file.puts("CH_LEN_080 put_startup_sw -------->FAILED\n")
	else
         if resp['boot software'] == "active"
                file.puts( "CH_LEN_080 - put_startup_sw -------->PASSED\n")
         else
                file.puts( "CH_LEN_080 - put_startup_sw -------->FAILED\n")
         end
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
	    "protocol" => "tftp",
	    "serverip" => "10.240.130.108",
	    "dstfile" => "temp/chid/" + conf,
            "srcfile" => "running_config",
	    "vrf_name" => "management"
            }
	resp = System.upload_sw_config(conn, params)
	if resp  != nil
	 file.puts("CH_LEN_085 upload_sw_config -------->PASSED\n")
	else
	 file.puts("CH_LEN_085 upload_sw_config -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
	    "protocol" => "tftp",
	    "serverip" => "10.240.130.108",
	    "srcfile" => "temp/chid/" + conf,
            "dstfile" => "running_config",
	    "vrf_name" => "management"
            }
	resp = System.download_sw_config(conn, params)
	if resp  != nil
	 file.puts("CH_LEN_083 download_sw_config -------->PASSED\n")
	else
	 file.puts("CH_LEN_083 download_sw_config -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = System.save_config(conn)
	if resp  != nil
	 file.puts("CH_LEN_084 save_config -------->PASSED\n")
	else
	 file.puts("CH_LEN_084 save_config -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        params = { 
	    "protocol" => "tftp",
	    "serverip" => "10.240.130.108",
            "dstfile" => "running_config",
	    "vrf_name" => "management"
            }
	resp = System.upload_tech_support(conn, params)
	if resp  != nil
	 file.puts("CH_LEN_086 upload_tech_support -------->PASSED\n")
	else
	 file.puts("CH_LEN_086 upload_tech_support -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        img = YAML.load_file(line)
        image = img['image']
        params = { 
	    "protocol" => "tftp",
	    "serverip" => "10.240.130.108",
	    "srcfile" => "temp/chid/" + image,
	    "imgtype" => "all",
	    "vrf_name" => "default"
            }
	resp = System.download_boot_img(conn, params)
	if resp  != nil
	 file.puts("CH_LEN_079 download_boot_img -------->PASSED\n")
	else
	 file.puts("CH_LEN_079 download_boot_img -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	resp = System.get_transfer_status(conn, 'download', 'image')
	if resp != nil
	 file.puts("CH_LEN_087 get_transfer_status -------->PASSED\n")
	else
	 file.puts("CH_LEN_087 get_transfer_status -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        puts "Sleeping to complete image download on switch"
        sleep(200)
	resp = System.reset_switch(conn)
	if resp  != nil
	 file.puts("CH_LEN_082 reset_switch -------->PASSED\n")
	else
	 file.puts("CH_LEN_082 reset_switch -------->FAILED\n")
        end
	file.puts( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
end

puts("\n\n\n CHECK \\tmp\\test_log.txt FOR RESULTS\n\n")
