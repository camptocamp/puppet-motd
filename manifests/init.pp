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
  exec { 'update motd':
    refreshonly => true,
    command     => $::osfamily ? {
      'RedHat' => 'true',
      'Debian' => $::lsbdistcodename ? {
        /wheezy/ => 'true',
        default  => 'uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd',
      },
    },
  }
}
