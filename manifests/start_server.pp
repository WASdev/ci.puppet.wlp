class liberty::start_server ($serverName = "server1") {
  # Start the server
  # $serverName the name of the server
  exec { "start_server":
    command => "server start $serverName",
    path    => "${liberty::variables::path}",
  }  
}