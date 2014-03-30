# Class: wlp
#
# The wlp module installs the WebSphere Liberty profile server from a source distribution.
# In addition it can be used to
# create server instances, install applications and start and stop the
# server instances
#
# Parameters: 
#
#    [*serverName*]
#    The name of the liberty server instance
#
#    [*baseDir*]
#    The base directory to extract the websphere liberty profile installable eg: If it is specified as liberty then
#    the server is installed at $install_root/liberty
#
#    [*appNames*]
#    Names of applications to install on the server instance
#
#    [*install_root*]
#    The root directory for installation of the Liberty profile instance
#
#    [*serverBinaryName*]
#    The name of the Websphere Liberty Profile binary.
#
#    [*appsDirName*]
#    The name of the directory containing the application artifacts.
#
#    [*extendedBinaryName*]
#    The name of the WebSphere Liberty profile extended binary.
#
#    [*extrasBinaryName*]
#    The name of the WebSphere Liberty profile extras binary.
#
#    [*mode*]
#    There are two modes of installation namely zip and archive
#
#    [*artifact*]
#    The artifact to install. can be base, extended, extras depending on which binary you want to install.
#
#    [*action*]
#    Specifies whether to install or uninstall the artifact -install, uninstall
#
#    [*java_home*]
#    The path to the JDK.
#
#    [*puppetFileRoot*]
#    The parent directory in which installables and application directories are specified. This need not be set if you are
#    specifying the $applicationSourceDirectory and $installablesDir variables.
#
#    [*applicationSourceDirectory*]
#    The full path to the directory where the application related files are located. The default value is
#    ${puppetFileRoot}/${appsDirName}. Thus if both "puppetFileRoot" and "appsDirName" are specified this is not required.
#
#    [*includesDir*]
#    The path of the directory where the includes files are located. You should normally not need to set this variable.
#
#    [*path*]
#    The path for the shell to start the server. The default value should be enough in most cases.
#
#    [*installablesDir*]
#    The directory where the installables are stored. The default value is ${puppetFileRoot}/installables.
#
##
# Actions:
##
#   [#install_wlp#]
#   This is defined in the install_wlp.pp manifest and can be used to install all the WebSphere Liberty Profile artifacts including
#   base extended and extras.
#
#   [#install_application#]
#   This is defined in the install_application.pp manifest and can be used to install different applications onto the Liberty
#   Profile server
#
#   [#create_server#]
#   This is defined in the create_server.pp manifest and can be used to create a new Liberty server.
#
#   [#start_server#]
#   This is defined in the start_server.pp manifest and can be used to start a Liberty instance.
#
#   [#stop_server#]
#   This is defined in the stop_server.pp manifest and can be used to stop a Liberty instance.
#
# Requires: see Modulefile
#
# Sample Usage:
#    class { "liberty":
#     appNames => ['DefaultApplication.ear',],
#     puppetFileRoot => "/home/puppetuser",
#     serverBinaryName => "wlp-developers-runtime-8.5.5.1.jar",
#    }
#
class wlp (
  $serverName         = 'UNSET',
  $baseDir            = 'UNSET',
  $appNames           = 'UNSET',
  $install_root       = 'UNSET',
  $serverBinaryName   = 'UNSET',
  $appsDirName        = 'UNSET',
  $extendedBinaryName = 'UNSET',
  $extrasBinaryName   = 'UNSET',
  $mode               = 'UNSET',
  $artifact           = 'UNSET',
  $action             = 'UNSET',
  $java_home          = 'UNSET',
  $puppetFileRoot     = 'UNSET',
  $applicationSourceDirectory = 'UNSET',
  $includesDir        = 'UNSET',
  $dependantLibs      = 'UNSET',
  $path               = 'UNSET',
  $installablesDir    = 'UNSET',
  $acceptLicense      = 'UNSET',
  $standalone         = 'UNSET') {
  include wlp::params
  $serverName_final = $serverName ? {
    'UNSET' => $::wlp::params::serverName,
    default => $serverName,
  }

  $baseDir_final = $baseDir ? {
    'UNSET' => $::wlp::params::baseDir,
    default => $baseDir,
  }

  $appNames_final = $appNames ? {
    'UNSET' => $::wlp::params::appNames,
    default => $appNames,
  }

  $install_root_final = $install_root ? {
    'UNSET' => $::wlp::params::install_root,
    default => $install_root,
  }

  $serverBinaryName_final = $serverBinaryName ? {
    'UNSET' => $::wlp::params::serverBinaryName,
    default => $serverBinaryName,
  }

  $appsDirName_final = $appsDirName ? {
    'UNSET' => $::wlp::params::appsDirName,
    default => $appsDirName,
  }

  $extendedBinaryName_final = $extendedBinaryName ? {
    'UNSET' => $::wlp::params::extendedBinaryName,
    default => $extendedBinaryName,
  }

  $extrasBinaryName_final = $extrasBinaryName ? {
    'UNSET' => $::wlp::params::extrasBinaryName,
    default => $extrasBinaryName,
  }

  $mode_final = $mode ? {
    'UNSET' => $::wlp::params::mode,
    default => $mode,
  }

  $artifact_final = $artifact ? {
    'UNSET' => $::wlp::params::artifact,
    default => $artifact,
  }

  $action_final = $action ? {
    'UNSET' => $::wlp::params::action,
    default => $action,
  }

  $java_home_final = $java_home ? {
    'UNSET' => $::wlp::params::java_home,
    default => $java_home,
  }

  $puppetFileRoot_final = $puppetFileRoot ? {
    'UNSET' => $::wlp::params::puppetFileRoot,
    default => $puppetFileRoot,
  }

  $applicationSourceDirectory_derived = "${puppetFileRoot_final}/${appsDirName_final}"
  
  $applicationSourceDirectory_final = $applicationSourceDirectory ? {
    'UNSET' => $applicationSourceDirectory_derived,
    default => $applicationSourceDirectory,
  }

  $includesDir_derived = "${install_root_final}/${baseDir_final}/wlp/usr/servers/${serverName_final}/includes"
  $includesDir_final = $includesDir ? {
    'UNSET' => $includesDir_derived,
    default => $includesDir,
  }

  $dependantLibs_final = $dependantLibs ? {
    'UNSET' => $::wlp::params::dependantLibs,
    default => $dependantLibs,
  }
  
  $path_derived = "${java_home_final}/bin:/opt/puppet/bin:${install_root_final}/${baseDir_final}/wlp/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
  $path_final = $path ? {
    'UNSET' => $path_derived,
    default => $path,
  }

  $installablesDir_derived = "${puppetFileRoot_final}/installables"
  $installablesDir_final = $installablesDir ? {
    'UNSET' => $installablesDir_derived,
    default => $installablesDir,
  }

  $acceptLicense_final = $acceptLicense ? {
    'UNSET' => $::wlp::params::acceptLicense,
    default => $acceptLicense,
  }

  $standalone_final = $standalone ? {
    'UNSET' => $::wlp::params::standalone,
    default => $standalone,
  }

  $serverBinary = "${installablesDir_final}/${serverBinaryName_final}"
  $extendedBinary = "${puppetFileRoot_final}/${extendedBinaryName_final}"
  $extrasBinary = "${puppetFileRoot_final}/${extrasBinaryName_final}"

  $serverBinary_final = "${serverBinary}"
  $extendedBinary_final = "${extendedBinary}"
  $extrasBinary_final = "${extrasBinary}"

  if ($standalone_final) {
    class { "wlp::install": } ->
    # Create the server
    class { "wlp::create_server": } ->
    class { "wlp::install_application": } ->
    class { "wlp::start_server": require => File["${wlp::install_root_final}/${wlp::baseDir_final}/wlp/usr/servers/${wlp::serverName_final}/server.xml"
        ], }
  }
}
