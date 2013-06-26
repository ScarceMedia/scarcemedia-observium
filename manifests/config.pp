class observium::config($config_path, $settings) {
  #validate_absolute_path($config_path)
  #validate_hash($settings)

  file{$config_path:
    ensure  => present,
    #owner   => 'root',
    #group   => 'root',
    mode    => '0644',
    content => template('observium/config.php.erb')
  }

}
