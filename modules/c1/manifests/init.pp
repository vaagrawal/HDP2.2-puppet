class c1{

	file {'/usr/local/tp':
	  ensure => present,
	  mode => 440,
	  owner => 'root',
	  group => 'root',
	  source => 'puppet:///modules/c1/tp' 
	}

}
