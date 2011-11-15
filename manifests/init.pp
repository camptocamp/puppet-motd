class motd {

  $path = $operatingsystem ? {
    /RedHat|CentOS|Fedora/ => "/etc/motd",
    /Debian|Ubuntu/ => "/etc/motd.tail",
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
