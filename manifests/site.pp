node default
{

  include java
}

node 'test3'{
include diskinc,selin,prereq,time_sync_c
	
#	file{'/usr/local/installjava.sh':
#        ensure=>'present',
#        mode=>'0755',
#        source=>'puppet:///modules/java/installjava.sh',
	#path=>'/bin/bash'
 #       }

#	exec{"java-install":
#	command=>"/usr/local/installjava.sh",
	#path=>"/bin/bash"
#	provider=>'shell'
#	}
	
}

Exec { path => [ "/usr/local/sbin/", "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" , "/bin/bash/"] }

class prereq{

	service { iptables:
                ensure => "stopped"
	}
	
	exec { "swappiness=0":
                command => "sysctl -w vm.swappiness=0"
	}
	
	 file { '/etc/sysctl.con':
                ensure => file,
                content => 'net.ipv6.conf.all.disable_ipv6=1',
	}

	exec{'mysql connector':
        command=>'yum install -y  mysql-connector-java'
        }
	exec{'ambari repo':
        command=>'wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo'
        }

	exec{'ambari client install':
	command=>'yum install -y ambari-agent',
	require=>Exec['ambari repo']
	}

}



node 'rocky.server'{
  include diskinc,selin,time_sync_c,prereq

	exec{'ambari server install':
	command=>'yum install -y ambari-server',
	require=>Exec['ambari repo']	
	}

	class{'::mysql::server':
        root_password=>'qwerty',
        remove_default_accounts=>true,
        restart=>true,
        service_enabled=>true,
#        service_manage=>true,
        override_options=>{'mysqld'=>{  'bind_address' => '10.2.0.201',
                                        'datadir'=>'/var/lib/mysql',
                                        'socket'=>'/var/lib/mysql/mysql.sock',
                                        'user'=>'mysql',
                                        'transaction-isolation'=>'READ-COMMITTED',
                                        'key_buffer'=>'16M',
                                        'key_buffer_size'=>'32M',
                                        'max_allowed_packet'=>'16M',
                                        'thread_stack'=>'256K',
                                        'thread_cache_size'=>'64',
                                        'query_cache_limit'=>'8M',
                                        'query_cache_size'=>'64M',
                                        'query_cache_type'=>'1',
                                        'max_connections'=>'550',
                                        'log-bin'=>'/var/lib/mysql/logs/binary/mysql_binary_log',
                                        'binlog_format'=>'mixed',
                                        'read_buffer_size'=>'2M',
                                        'read_rnd_buffer_size'=>'16M',
                                        'sort_buffer_size'=>'8M',
                                        'join_buffer_size'=>'8M',
                                        'default-storage_engine'=>'InnoDB',
                                        'innodb_file_per_table'=>'1',
                                        'innodb_flush_log_at_trx_commit'=>'2',
                                        'innodb_log_buffer_size'=>'64M',
                                        'innodb_buffer_pool_size'=>'4G',
                                        'innodb_thread_concurrency'=>'8',
                                        'innodb_flush_method'=>'O_DIRECT',
                                        'innodb_log_file_size'=>'512M'
                                        },
                        'mysqld_safe'=>{'log-error'=>'/var/mysqld.log',
                                        'pid-file'=>'/var/run/mysqld/mysqld.pid'
                                        }
                        }
        }


}

node 'rocky.node1' {
include diskinc,selin,time_sync_c,prereq
}

node 'rocky.node2'{
include diskinc,selin,time_sync_c,prereq
}

node 'rocky.node3'{
include diskinc,selin,time_sync_c,prereq
}


node 'rocky.node4'{
include diskinc,selin,time_sync_c,prereq

}


node 'rocky.client'{
include diskinc,selin,time_sync_s,prereq

}





