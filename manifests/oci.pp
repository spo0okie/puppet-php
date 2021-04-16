class php::oci {
	case $::operatingsystem {
		'CentOS': {
			include repos::remi
			include oracle_client
			package {'libaio':		ensure => 'installed' } ->
			php::module {'php-oci8': }
		}
		'Debian','Ubuntu': {
		}
	}
}

