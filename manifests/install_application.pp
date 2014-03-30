class wlp::install_application {
  # Copy all application files to the server

  file { "${wlp::includesDir_final}/": 
    ensure => "directory"
  }->
  copy_xml { $wlp::appNames_final: }

  copy_app { $wlp::appNames_final: }

}

define copy_xml {
  $from_dir = "${wlp::applicationSourceDirectory_final}"

  $arr = split($title, '[.](ZIP|zip|[EeJjRrWw][Aa][Rr]|[Ee][BbSs][Aa])')
  $titlename = $arr[0]

  file { "${wlp::includesDir_final}/${titlename}.xml": 
    source => "$from_dir/${titlename}.xml" 
  }

}

define copy_app {
  $from_dir = "${wlp::applicationSourceDirectory_final}"
  $to_dir = "${wlp::install_root_final}/$wlp::baseDir_final/wlp/usr/servers/${wlp::serverName_final}/apps/"
    
  file { "$to_dir/${title}":
    source   => "${from_dir}/${title}",
  }

}
