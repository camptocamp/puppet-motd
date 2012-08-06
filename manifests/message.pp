define motd::message ($source='', $content='') {

  include motd

  concat::fragment { $name:
    target=> "${motd::path}",
    source => $source ? {
      default => $source,
      '' => false,
    },
    content => $content ? {
      default => $content,
      '' => false,
    },
  }

}
