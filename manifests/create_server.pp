class liberty::create_server  {
  
  $apps = $liberty::variables::appNames
#  notify {$apps:}

  # Create the server
  exec { "create_server":
    command => "server create ${liberty::variables::serverName}",    
    path    => "${liberty::variables::path}",
    require => Class['liberty::install_wlp'],
  }  ->

 # Copy the server.xml to the server
  file { "${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/usr/servers/${liberty::variables::serverName}/server.xml":
        mode    => "0644",
        content  => template("liberty/server.xml.erb"),
        replace => true,
        require => Exec["create_server"],
  } 
 
}

