class wlp::params{
  $serverName         = 'server1'
  $baseDir            = "liberty"
  $appNames           = ['DefaultApplication.ear',]
  $install_root       = "/opt/IBM/"  
  $serverBinaryName   = "wlp-developers-runtime-8.5.5.1.jar"
  $appsDirName        = "apps"
  $extendedBinaryName = "wlp-developers-extended-8.5.5.1.jar"
  $extrasBinaryName   = "wlp-developers-extras-8.5.5.1.jar"
  $mode               = "archive"
  $artifact           = "base"
  $action             = "install"
  $java_home          = "/usr/lib/jvm/java-1.6.0"
  $puppetFileRoot     = "/home/puppetuser/"
  $acceptLicense      = false
  $standalone         = true

}