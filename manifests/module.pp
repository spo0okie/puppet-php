#устанавливает пакет для PHP, 
#если указана версия, то добавляет префикс

define php::module () {
	case $php::version {
		undef, '': {
			#если версия из коробки - просто накатываем модуль
			if ! defined(Package[$title]){
				notify{ "adding module ${title} of default version" : }
				package {$title:	ensure=>installed}
			}
		}
		default: {
			#если кастоменая - удаляем модуль из коробки и ставим кастомный
			#notify{ "adding module ${title} of version $php::version" : }


			case $::operatingsystem {
				'CentOS': {
					if ! defined(Package[$title]){
						package {$title:	ensure=>purged}
					}
					if ! defined(Package["${php::prefix}-${title}"]){
						#notify{ "adding module ${php::prefix}-${title} of version $php::version" : }
						package {
							"${php::prefix}-${title}":
							ensure	=>installed,
							notify	=>Service['httpd'],
							require	=>Exec['install_remi_key']
						}
					}
				}
				'Debian': {
					if ! defined(regsubst($title, '^php', "$php::prefix", '')){
						#notify{ "adding module ${title} of version $php::version" : }
						package {
							regsubst($title, '^php', "$php::prefix", ''):
							ensure	=>installed,
							notify	=>Service['apache2'],
						}
					}
				}
			}
		}
	}
}

class php::module::default {
	php::module {
		'php':          ;
		'php-cli':      ;
		'php-common':   ;
	}
}
