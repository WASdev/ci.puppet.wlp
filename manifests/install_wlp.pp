class liberty::install_wlp {

  # create IBM directory
  file { "${liberty::variables::install_root}": ensure => "directory", } 
  
  if ("${liberty::variables::action}" == 'install') {
    if "${liberty::variables::artifact}" == 'base' {
      if "${liberty::variables::mode}" == 'zip' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unzip_wlp":
          command => "unzip -od ${liberty::variables::install_root}/${liberty::variables::baseDir} ${liberty::variables::serverBinary}",
          path    => "${liberty::variables::path}",
        } ->
        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }

      } elsif "${liberty::variables::mode}" == 'archive' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unjar_wlp":
          command => "java -jar ${liberty::variables::serverBinary} --acceptLicense ${liberty::variables::install_root}/${liberty::variables::baseDir}",
          path    => "${liberty::variables::path}",
        } ->
        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }

      }
    }

    if "${liberty::variables::artifact}" == 'extended' {
      if "${liberty::variables::mode}" == 'zip' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unzip_wlp":
          command => "unzip -od ${liberty::variables::install_root}/${liberty::variables::baseDir} ${liberty::variables::extendedBinary}",
          path    => "${path}",
        }->

        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }
      } elsif "${liberty::variables::mode}" == 'archive' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unjar_wlp":
          command => "java -jar ${liberty::variables::extendedBinary} --acceptLicense ${liberty::variables::install_root}/${liberty::variables::baseDir}",
          path    => "${path}",
        }->

        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }
      }
    }

    if "${liberty::variables::artifact}" == 'extras' {
      if "${liberty::variables::mode}" == 'zip' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unzip_wlp":
          command => "unzip -od ${liberty::variables::install_root}/${liberty::variables::baseDir} ${liberty::variables::extrasBinary}",
          path    => "${path}",
        }->

        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }
      } elsif "${liberty::variables::mode}" == 'archive' {
        # create IBM directory
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": ensure => "directory", } ->
        # extract from source to ${liberty::variables::install_root}
        exec { "unjar_wlp":
          command => "java -jar ${liberty::variables::extrasBinary} --acceptLicense ${liberty::variables::install_root}/${liberty::variables::baseDir}",
          path    => "${path}",
        }->

        # change permissions for ${liberty::variables::install_root}/wlp/
        file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/bin": 
          mode => 777, 
          recurse => true,
        }
      }
    }
  } elsif ("${liberty::variables::action}" == 'uninstall') {
       class { "liberty::stop_server":
       } ->
       file { "${liberty::variables::install_root}/${liberty::variables::baseDir}": 
         ensure => absent,
         recurse => true,
       }
  }
}
