class liberty::stop_server {
  # Start the server
  exec { "stop_server":
    command => "server stop ${liberty::variables::serverName}",
    path    => "${liberty::variables::path}",
  }
}