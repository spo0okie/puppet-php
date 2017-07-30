#идея такая что при инициализации php можно указать версию
#и тогда пакеты все будут ставиться с префиксом php56-


class php (
	$version	= '',		#по умолчанию версия php "из коробки"
) {
	require repos
	require repos::remi
	case $version {
		'': {
			$prefix=''
		}
		default: {
			$prefix="php$version-"
		}
	}
	include '::php::module::default'
}

