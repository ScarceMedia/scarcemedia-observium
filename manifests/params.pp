class observium::params {
  case $::osfamily {
    'RedHat': {
      $packages = [
        'php', 
        'php-mysql', 
        'php-gd', 
        'php-snmp', 
        'vixie-cron', 
        'php-pear', 
        'net-snmp', 
        'net-snmp-utils', 
        'graphviz', 
        'subversion',
        'rrdtool',
        'fping', 
        'ImageMagick', 
        'jwhois',
        'nmap',
        'OpenIPMI-tools',
        'php-pear',
        'MySQL-python'
        ]
    }
    default: {
      fail("${::osfamily} is not supported")
    }
  }
}
