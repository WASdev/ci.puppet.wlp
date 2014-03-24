class liberty::install_application {
  # Copy all application files to the server
  # $appNames = ["test1", "test2", "test3","test4",]
  # $applicationSourceDirectory = "${::puppetFileRoot}${::appsDirName}"

  file { "${liberty::variables::includesDir}/": 
    ensure => "directory"
  }->
  copy_xml { $liberty::variables::appNames: }

  copy_app { $liberty::variables::appNames: }

}

define copy_xml {
  $from_dir = "${liberty::variables::applicationSourceDirectory}"

  $arr = split($title, '[.](ZIP|zip|[EeJjRrWw][Aa][Rr]|[Ee][BbSs][Aa])')
  $titlename = $arr[0]

  file { "${liberty::variables::includesDir}/${titlename}.xml": 
    source => "$from_dir/${titlename}.xml" 
  }

}

define copy_app {
  $from_dir = "${liberty::variables::applicationSourceDirectory}"
  $to_dir = "${liberty::variables::install_root}/$liberty::variables::baseDir/wlp/usr/servers/${liberty::variables::serverName}/${liberty::variables::appsDirName}/"
    
  file { "$to_dir/${title}":
    source   => "${from_dir}/${title}",
  }

}
