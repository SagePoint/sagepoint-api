import 'motd.pp'

package { 'build-essential':
	ensure => installed
}

import 'passenger.pp'