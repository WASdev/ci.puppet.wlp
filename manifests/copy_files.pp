class wlp::copy_files {
  exec { "create_directory":
    command => "mkdir -p ${wlp::installablesDir_final}",
    path    => "${wlp::path_final}",
  } ->
  file { "${wlp::installablesDir_final}":
    ensure  => directory,
    recurse => true,
  } ->
  file { "${wlp::installablesDir_final}/${wlp::serverBinaryName_final}":
    mode   => 777,
    owner  => root,
    group  => root,
    source => "puppet:///modules/wlp/${wlp::serverBinaryName_final}",
  } ->
  file { "${wlp::applicationSourceDirectory_final}":
    mode    => 777,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/wlp/${wlp::appsDirName_final}/",
    recurse => true,
    ensure  => directory,
  }

}
