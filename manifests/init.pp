# Class: liberty
#
# This module manages liberty
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class liberty  {
  include liberty::variables
  # Install the liberty profile
  class { "liberty::install_wlp":
  } ->

  # Create the server
  class { "liberty::create_server":
  } ->
  
  class { "liberty::install_application":
  } -> 
   
  class { "liberty::extremescale":
  } ->

  class { "liberty::start_server":
        require =>  File["${liberty::variables::install_root}/${liberty::variables::baseDir}/wlp/usr/servers/${liberty::variables::serverName}/server.xml"],
  }

}
