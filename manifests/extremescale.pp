
class liberty::extremescale {

  class { "liberty::install_xs":
    #subscribe => File["${liberty::variables::extremeScaleLibertyBinary}", "${liberty::variables::extremeScaleBinary}"],
    require =>  File["${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/usr/servers/${liberty::variables::serverName}/server.xml"],    
  } ->

  class { "liberty::setup_acmeair":
  }       
}
