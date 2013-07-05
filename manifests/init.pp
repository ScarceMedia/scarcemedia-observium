# == Class: observium
#
# Full description of class observium here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { observium:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class observium($install_path, $settings, $revision=unset) {
  include ::observium::params
  validate_absolute_path($install_path)
  validate_hash($config_hash)

  $config_path = "${install_path}/config.php"

  ensure_packages($::observium::params::packages)

  exec{'observium-update-database':
    command     => "${install_path}/discovery.php -h none",
    refreshonly => true,
    require     => File[$config_path]
  }

  vcsrepo { $install_path:
    ensure   => present,
    provider => svn,
    source   => 'http://www.observium.org/svn/observer/trunk/',
    revision => $revision, 
    notify   => Exec['observium-update-database']
  }

  file{$config_path:
    ensure  => present,
    #owner  => 'root',
    #group  => 'root',
    mode    => '0644',
    content => template('observium/config.php.erb'), 
    require => Vcsrepo[$install_path]
  }
}
