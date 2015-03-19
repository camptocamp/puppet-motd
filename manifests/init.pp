class motd {

  $path = $::osfamily ? {
    'RedHat' => '/etc/motd',
    'Debian' => $::lsbdistcodename ? {
      /wheezy/ => '/etc/motd',
      default  => '/etc/motd.tail',
    },
  }

  concat {$path:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['update motd'],
  }

  # debian rewrites his motd, see /etc/init.d/bootmisc.sh
  # lint:ignore:quoted_booleans
  case $::osfamily {
    'Debian': {
      $command = $::lsbdistcodename ? {
        /wheezy/ => 'true',
        default  => 'uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd',
      }
    }
    'Redhat': {
      $command = 'true'
    }
    default: {
      fail "Unsupported Operating System family: ${::osfamily}"
    }
  }
  # lint:endignore
  exec { 'update motd':
    refreshonly => true,
    command     => $command,
    path        => $::path,
  }
}
