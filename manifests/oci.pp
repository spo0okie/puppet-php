class php::oci {
	include repos::remi
	include oracle_client
	package {'libaio':		ensure => 'installed' } ->
	php::module {'php-oci8': }
}

