class liberty::variables ($serverName = "server1", 
$baseDir = "liberty", 
$appNames = [ 'acmeair-webapp-1.0-SNAPSHOT.war','DefaultApplication.ear',], 
$extremeScaleBinaryName="extremescaletrial860.zip",
$install_root="/opt/IBM/", 
$wxs_serverdirName = "ObjectGrid", 
$extremeScaleLibertyBinaryName="wxs-wlp_8.6.0.4.jar", 
$user = "puppetuser", 
$serverBinaryName="wlp-developers-runtime-8.5.5.1.jar",
$appsDirName = "apps", 
$extendedBinaryName="wlp-developers-extended-8.5.5.1.jar", 
$extrasBinaryName="wlp-developers-extras-8.5.5.1.jar", 
$mode = "archive",
$artifact = "base", 
$action = "install", 
$java_home = "/usr/lib/jvm/java-1.6.0",
$userHome = "/home/${user}",
$puppetFileRoot="${userHome}",
$applicationSourceDirectory = "${puppetFileRoot}/${appsDirName}"

 ) {
# $mode There are two modes of installation namely zip and archive
# $baseDir The base directory to extract the artifact to
# $artifact The artifact to install. can be base, extended, extras
# $action whether to install or uninstall the artifact -install, uninstall
$includesDir ="${liberty::variables::install_root}/${baseDir}/wlp/usr/servers/${serverName}/includes"
$extremeScaleBinary = "${puppetFileRoot}/${extremeScaleBinaryName}"
$extremeScaleLibertyBinary = "$puppetFileRoot/${extremeScaleLibertyBinaryName}"
$dependantLibs = "$puppetFileRoot/lib"
$serverBinary = "${puppetFileRoot}/${liberty::variables::serverBinaryName}"
$applicationFileName = $appNames
$extendedBinary = "${puppetFileRoot}/${extendedBinaryName}"
$extrasBinary   = "${puppetFileRoot}/${extrasBinaryName}"
$path = "${liberty::variables::java_home}/bin:/opt/puppet/bin:${liberty::variables::install_root}/${baseDir}/wlp/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
$wxs_serverdir = "${install_root}/${wxs_serverdirName}"
$env_file = "env.sh"
$deploymentconfig = "deployment.xml"
$objectgridconfig = "objectgrid.xml"
$sample_cp = "$SAMPLE_COMMON_CLASSPATH:$dependantLibs/acmeair-common-1.0-SNAPSHOT.jar:$dependantLibs/acmeair-services-wxs-1.0-SNAPSHOT.jar:$dependantLibs/commons-logging-1.1.1.jar"
$loader_class_path = "$sample_cp:$dependantLibs/acmeair-loader-1.0-SNAPSHOT.jar:$dependantLibs/acmeair-services-1.0-SNAPSHOT.jar:$dependantLibs/aspectjweaver-1.6.8.jar:$dependantLibs/aspectjrt-1.6.8.jar:$dependantLibs/cglib-2.2.2.jar:$dependantLibs/spring-tx-3.1.2.RELEASE.jar:$dependantLibs/spring-core-3.1.2.RELEASE.jar:$dependantLibs/spring-context-3.1.2.RELEASE.jar:$dependantLibs/spring-beans-3.1.2.RELEASE.jar:$dependantLibs/spring-expression-3.1.2.RELEASE.jar:$dependantLibs/spring-aop-3.1.2.RELEASE.jar:$dependantLibs/spring-asm-3.1.2.RELEASE.jar:$dependantLibs/asm-3.3.1.jar:$dependantLibs/aopalliance-1.0.jar:$dependantLibs/jsr305-1.3.9.jar:$dependantLibs/guava-12.0.jar:$dependantLibs/slf4j-api-1.6.5.jar:$dependantLibs/logback-core-1.0.6.jar:$dependantLibs/logback-classic-1.0.6.jar:$dependantLibs/objectgrid-8.6.0.2.jar"
}

