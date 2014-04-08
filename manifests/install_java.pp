class wlp::install_java {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>
  package { "openjdk-7-jdk":
    ensure => "installed",
    install_options => [ '/S', { 'INSTALLDIR' => '/opt/jdk' } ],
  }
}