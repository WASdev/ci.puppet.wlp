class liberty::install_xs  {

  $wxs_serverdir = "${liberty::variables::install_root}${liberty::variables::wxs_serverdirName}"
  
#  file { "extremeScaleBinaryIsPresent":
#    path     => "${liberty::variables::extremeScaleBinary}",
#    ensure   => file,
#  } ->
#  
#  file { "extremeScaleLibertyBinaryIsPresent":
#    path => "${liberty::variables::extremeScaleLibertyBinary}",
#    ensure   => file,
#  } ->
      
  # extract from source to ${liberty::variables::install_root}
  exec { "unzip_es":
    command => "unzip -od ${liberty::variables::install_root} ${liberty::variables::extremeScaleBinary}",
    path    => "${liberty::variables::path}",
    require =>  File["${liberty::variables::extremeScaleBinary}"],
  } ->

  # augment liberty with extremeScale client
  exec { "unjar_es_lib_bin":
    command => "java -jar ${liberty::variables::extremeScaleLibertyBinary} --acceptLicense --overwrite ${liberty::variables::install_root}/${liberty::variables::baseDir}",
    path    => "${liberty::variables::path}",
    require =>  File["${liberty::variables::extremeScaleLibertyBinary}"],
  }->

  # augment liberty with extremeScale client
  #exec { "unzip_es_lib_bin":
  #      command => "unzip -od ${liberty::variables::install_root}/${liberty::variables::baseDir} ${liberty::variables::extremeScaleLibertyBinary}",
  #      path    => "${liberty::variables::path}",
  #} ->
              
  # change permissions for ${liberty::variables::install_root}/ObjectGrid/bin
  file { "$wxs_serverdir/bin": mode => 777, }
      
}
