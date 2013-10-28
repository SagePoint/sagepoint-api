node 'sagepoint-portal' {
  # Configure mysql

  	class { 'mysql': }

	class { 'mysql::server':
		config_hash => { 'root_password' => 'root' }
 	}

 	class { 'rvm': version => '1.22.1' }

 	rvm_system_ruby {
 		'ruby-2.0.0-rc2':
 		ensure => 'present',
 		default_use => true;
 	}

	class { 'rvm::passenger::apache':
	    version => '4.0.10',
	    ruby_version => 'ruby-2.0.0-rc2',
	    mininstances => '3',
	    maxinstancesperapp => '0',
	    maxpoolsize => '30',
	    spawnmethod => 'smart-lv2';
	}

}

