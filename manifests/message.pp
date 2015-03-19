define motd::message(
  $source  = undef,
  $content = undef,
) {

  include ::motd

  concat::fragment { $name:
    target  => $::motd::path,
    source  => $source,
    content => $content,
  }

}
