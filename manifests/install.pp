class wlp::install {
  # create IBM directory
  file { "${wlp::install_root_final}": ensure => "directory", }

  if ("${wlp::acceptLicense_final}" == false) {
    notify { "Accept the License by setting the acceptLicense parameter to true.": }
  } else {
    if ("${wlp::action_final}" == 'install') {
      if "${wlp::artifact_final}" == 'base' {
        if "${wlp::mode_final}" == 'zip' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unzip_wlp":
            command => "unzip -od ${wlp::install_root_final}/${wlp::baseDir_final} ${wlp::serverBinary_final}",
            path    => "${wlp::path_final}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }

        } elsif "${wlp::mode_final}" == 'archive' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unjar_wlp":
            command => "java -jar ${wlp::serverBinary_final} --acceptLicense ${wlp::install_root_final}/${wlp::baseDir_final}",
            returns => ["0","4",],
            path    => "${wlp::path_final}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }

        }
      }

      if "${wlp::artifact_final}" == 'extended' {
        if "${wlp::mode_final}" == 'zip' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unzip_wlp":
            command => "unzip -od ${wlp::install_root_final}/${wlp::baseDir_final} ${wlp::extendedBinary_final}",
            path    => "${path}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }
        } elsif "${wlp::mode_final}" == 'archive' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unjar_wlp":
            command => "java -jar ${wlp::extendedBinary_final} --acceptLicense ${wlp::install_root_final}/${wlp::baseDir_final}",
            path    => "${path}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }
        }
      }

      if "${wlp::artifact_final}" == 'extras' {
        if "${wlp::mode_final}" == 'zip' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unzip_wlp":
            command => "unzip -od ${wlp::install_root_final}/${wlp::baseDir_final} ${wlp::extrasBinary_final}",
            path    => "${path}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }
        } elsif "${wlp::mode_final}" == 'archive' {
          # create IBM directory
          file { "${wlp::install_root_final}/${wlp::baseDir_final}": ensure => "directory", } ->
          # extract from source to ${liberty::variables::install_root}
          exec { "unjar_wlp":
            command => "java -jar ${wlp::extrasBinary_final} --acceptLicense ${wlp::install_root_final}/${wlp::baseDir_final}",
            path    => "${path}",
          } ->
          # change permissions for ${liberty::variables::install_root}/wlp/
          file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/bin":
            mode    => 777,
            recurse => true,
          }
        }
      }
    } elsif ("${wlp::action_final}" == 'uninstall') {
      class { "wlp::stop_server": } ->
      file { "${wlp::install_root_final}/${wlp::baseDir_final}":
        ensure  => absent,
        recurse => true,
      }
    }
  }
}
