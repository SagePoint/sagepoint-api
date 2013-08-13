node 'sagepoint-portal' {
  # Configure mysql

	class { 'mysql::server':
		config_hash => { 'root_password' => 'root' }
 	}

 	class { 'rvm': version => 'latest' }

 	rvm_system_ruby {
 		'ruby-2.0.0-rc2':
 		ensure => 'present',
 		default_use => true;
 	}

	class { 'rvm::passenger::apache':
	    version => 'latest',
	    ruby_version => 'ruby-2.0.0-rc2',
	    mininstances => '3',
	    maxinstancesperapp => '0',
	    maxpoolsize => '30',
	    spawnmethod => 'smart-lv2';
	}
}