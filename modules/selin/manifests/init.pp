class selin{
        file{"/usr/local/selin":
        ensure=>directory
        }
	
	file{"/usr/local/selin/dis_se.sh":
	ensure=>present,
	source=>'puppet:///modules/selin/dis_se.sh',
	require=>File["/usr/local/selin"]
	}

}
