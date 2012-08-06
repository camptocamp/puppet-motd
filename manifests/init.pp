class motd {

  $path = $operatingsystem ? {
    /RedHat|CentOS|Fedora/ => "/etc/motd",
    /Debian|Ubuntu/ => "/etc/motd.tail",
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
      /RedHat|CentOS|Fedora/ => "true",
      /Debian|Ubuntu/ => "uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd",
    },
  }
}
