class {'observium::config':
  config_path => '/tmp/config.php',
  settings => {
    'install_dir' => '/opt/observium',
    'temp_dir'    => '/tmp',
    'snmp' => {
      'community' => ['public', 'public1']
    },
    'alerts' => {
      'ports' => {
        'ifdown' => false
      }
    }, 
    'db_host' => 'localhost',
    'db_user' => 'observium',
    'db_pass' => 'password',
    'db_name' => 'observium'
  }
}
