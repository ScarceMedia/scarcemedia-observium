define obserium::poller($ensure, $total_instances=unset, $user=unset, $install_path=unset, $log_root='/var/log/observium', $cron_interval='5') {
  validate_re($name, '^\d+$')
  
  $cron_name  "observium_poller_${name}"
  $log_name = "poller.${name}.log"

  case $ensure {
    'present': {
      validate_absolute_path($install_path, $log_root)
      validate_re($total_instances, $cron_interval, '^\d+$')
      validate_string($user)

      $log_path = "${log_root}/${log_name}"

      if(!defined(File[$log_root])){
        file{$log_root:
          ensure => directory,
        }
      }

      logrotate::rule { $log_name:
        ensure       => present,
        path         => $log_path,
        rotate       => 5,
        rotate_every => 'day',
        compress     => true,
      }

      cron { $cron_name:
        ensure  => present,
        command => "${install_path}/poller.php",
        user    => root,
        minute  => "*/${cron_interval}"
      }
    }
    'absent':{
      logrotate::rule { $log_name:
        ensure       => absent,
      }

      cron { $cron_name:
        ensure  => absent,
      }
    }
  }
}
