class java{

	file{'/usr/local/installjava.sh':

	  ensure=>'present',
	  mode=>'0755',
	  source=>'puppet:///modules/java/installjava.sh',
	
	
	}

	exec{'/usr/local/installjava.sh':
	refreshonly=>true,	
	require=>File['/usr/local/installjava.sh'],
	subscribe=>File['/usr/local/installjava.sh'],
	command=>'/usr/local/installjava.sh',
	#path=>'/usr/local/',
	user=>'root',
	provider=>'shell'

	}

}
