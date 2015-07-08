class time_sync_s{

	file{'/etc/localtime':
	ensure=>'present',
	source=>'puppet:///modules/time_sync_s/localtime'
	}

	package{'ntp':
	ensure=>installed,
	require=>File['/etc/localtime']
	}

	file{'/etc/ntp.conf':
	ensure=>'present',
	source=>'puppet:///modules/time_sync_s/ntpserv',
	require=>Package['ntp']
	}

	service{'ntpd':
	ensure=>'running',
	require=>File['/etc/ntp.conf'];
	}

}
