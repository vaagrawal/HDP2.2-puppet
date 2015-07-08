class diskinc{

	file{"/usr/local/diskinc":
		ensure=>directory,
	}

	file{"/usr/local/diskinc/vol1.sh":
	ensure=>present,
	source=>'puppet:///modules/diskinc/vol1.sh',
	require=>File["/usr/local/diskinc"]	
	}

	 file{"/usr/local/diskinc/vol2.sh":
	ensure=>present,
	source=>'puppet:///modules/diskinc/vol2.sh', 
	require=>File["/usr/local/diskinc"] 
	}

	 file{"/usr/local/diskinc/vol3.sh":
	ensure=>present,
	source=>'puppet:///modules/diskinc/vol3.sh',        
	require=>File["/usr/local/diskinc"]
	}
}
