define motd::message ($source='', $content='') {

  include motd

  concat::fragment { $name:
    target=> "${motd::path}",
    source => $source ? {
      default => $source,
      '' => undef,
    },
    content => $content ? {
      default => $content,
      '' => undef,
    },
  }

}
