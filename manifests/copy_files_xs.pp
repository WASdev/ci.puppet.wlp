class liberty::copy_files_xs  {
  exec { "create_directory":
    command => "mkdir -p "${liberty::variables::puppetFileRoot}",
    path    => "${liberty::variables::path}",
  }
  ->  
  file { "${liberty::variables::puppetFileRoot}/${liberty::variables::extremeScaleBinaryName}":
    mode   => 777,
    owner  => root,
    group  => root,
    source => "puppet:///modules/liberty/${liberty::variables::extremeScaleBinaryName}",
  }
  ->  
  file { "${liberty::variables::puppetFileRoot}/${liberty::variables::extremeScaleLibertyBinaryName}":
    mode   => 777,
    owner  => root,
    group  => root,
    source => "puppet:///modules/liberty/${liberty::variables::extremeScaleLibertyBinaryName}",
  }  
  ->
  file { "dependantLibs":
    path    => "${liberty::variables::dependantLibs}",
    mode    => 777,
    owner   => root,
    group   => root,
    ensure => directory,
    recurse => true,
    source  => "puppet:///modules/liberty/dependantLibs",
  } 
#  ->  
#  class { "::liberty":
#    require =>  File["${liberty::variables::puppetFileRoot}/${liberty::variables::appsDirName}"],
#  }
  
}
