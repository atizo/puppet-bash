# modules/bash/manifests/init.pp - manage bash stuff
# Copyright (C) 2007 admin@immerda.ch
#

modules_dir { "bash": }

class bash {

        case $operatingsystem {
                OpenBSD: {

			 package{'libiconv':
				ensure => 'present',
				source => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/libiconv-1.9.2p3.tgz'
			 }

			 package {'gettext':
				ensure => 'present',
				source => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/gettext-0.14.6p0.tgz',
			 }
			 package { 'bash':
		                ensure => 'present',
		                #source => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/bash-3.2.17.tgz',
		                env => $opratingsystem ? {
					openbsd => "PKG_PATH=ftp://mirror.switch.ch/pub/OpenBSD/`uname -r`/packages/`uname -m`",
					default => undev,
				}
        		}
                }
        }
}

define bash::deploy_profile( 
	$source, 
	$destination = '/root/.bash_profile',
	$uid    = 'root',
        $gid    = '0' ){

        file {$name:
                path => $destination,
                owner => $uid,
                group => $gid,
                mode => 600,
                source => "puppet://$server/bash/${source}",
        }
}
