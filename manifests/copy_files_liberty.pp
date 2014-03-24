class liberty::copy_files_liberty  {
  exec { "create_directory":
    command => "mkdir -p ${liberty::variables::puppetFileRoot}",
    path    => "${liberty::variables::path}",
  } 
  ->  
  file { "${liberty::variables::puppetFileRoot}": ensure => directory, recurse => true,}
  ->
  file { "${liberty::variables::puppetFileRoot}/${liberty::variables::serverBinaryName}":
    mode   => 777,
    owner  => root,
    group  => root,
    source => "puppet:///modules/liberty/${liberty::variables::serverBinaryName}",
  }
  ->
  file { "${liberty::variables::applicationSourceDirectory}":
    mode    => 777,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/liberty/${liberty::variables::appsDirName}/",
    recurse => true,
    ensure  => directory,
  }  
}
