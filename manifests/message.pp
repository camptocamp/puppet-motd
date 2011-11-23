define motd::message ($source='', $content='') {

  include motd

  common::concatfilepart { $name:
    file   => "${motd::path}",
    manage => true,
    source => $source ? {
      default => $source,
      '' => false,
    },
    content => $content ? {
      default => $content,
      '' => false,
    },
    notify => Exec["update motd"],
  }

}
