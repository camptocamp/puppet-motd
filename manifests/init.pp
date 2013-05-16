class motd {

  $path = $operatingsystem ? {
    /RedHat|CentOS|Fedora/ => "/etc/motd",
    /Debian|Ubuntu/ => $lsbdistcodename ? {
      /wheezy/ => "/etc/motd",
      default  => "/etc/motd.tail",
    },
  }

  include concat::setup

  concat {$path:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['update motd'],
  }

  # debian rewrites his motd, see /etc/init.d/bootmisc.sh
  exec { "update motd":
    refreshonly => true,
    command     => $operatingsystem ? {
      /RedHat|CentOS|Fedora/ => "/bin/true",
      /Debian|Ubuntu/ => $lsbdistcodename ? {
        /wheezy/ => "/bin/true",
        default  => "/bin/uname -snrvm > /var/run/motd && /bin/cat /etc/motd.tail >> /var/run/motd",
      },
    },
  }
}
