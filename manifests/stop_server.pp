class wlp::stop_server {
  # Start the server
  exec { "stop_server":
    command => "server stop ${wlp::serverName_final}",
    path    => "${wlp::path_final}",
  }
}