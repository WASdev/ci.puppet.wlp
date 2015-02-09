class wlp::create_server  {
  
  $apps = $wlp::appNames_final
  # Create the server
  exec { "create_server":
    command => "server create ${wlp::serverName_final}",    
    path    => "${wlp::path_final}",
    returns => ["0","1",],
    require => Class['wlp::install'],
  }  ->
 # Copy the server.xml to the server
  file { "${wlp::install_root_final}/${wlp::baseDir_final}/wlp/usr/servers/${wlp::serverName_final}/server.xml":
        mode    => "0644",
        content  => template("wlp/server.xml.erb"),
        replace => true,
        require => Exec["create_server"],
  }  
}

