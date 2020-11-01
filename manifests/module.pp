#устанавливает пакет для PHP, 
#если указана версия, то добавляет префикс

define php::module () {
	case $php::version {
		'': {
			#если версия из коробки - просто накатываем модуль
			if ! defined(Package[$title]){
				#notify{ "adding module ${title} of default version" : }
				package {$title:	ensure=>installed}
			}
		}
		default: {
			#если кастоменая - удаляем модуль из коробки и ставим кастомный
			#notify{ "adding module ${title} of version $php::version" : }
			if ! defined(Package[$title]){
				package {$title:	ensure=>purged}
			}
			if ! defined(Package["$php::prefix$title"]){
				package {
					"$php::prefix$title":
					ensure	=>installed,
					notify	=>Service['httpd'],
					require	=>Exec['install_remi_key']
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
