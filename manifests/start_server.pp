class wlp::start_server {
  # Start the server
  # $serverName the name of the server
  exec { "start_server":
    command => "server start ${wlp::serverName_final}",
    path    => "${wlp::path_final}",
  }  
}