define motd::message(
  $content,
) {

  include ::motd

  concat::fragment { $name:
    target  => $::motd::path,
    content => $content,
  }

}
