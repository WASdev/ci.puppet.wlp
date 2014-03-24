class liberty::setup_acmeair {
    
  # Create a WebSphere eXtreme Scale configuration
  file { "${liberty::variables::wxs_serverdir}/acmeair":
        mode    => "0777",
        source  => "${liberty::variables::wxs_serverdir}/gettingstarted/",
        ensure  => present,
        recurse => true,
        replace => true,
        require => Class['liberty::install_xs'],
  } ->
   
  # Customize the env.sh
  file { 'env.sh':
        path     => "${liberty::variables::wxs_serverdir}/acmeair/env.sh",
        ensure   => file,
        #require => Package['liberty'],
        content  => template("liberty/${liberty::variables::env_file}.erb"),
        replace  => true,
        mode => 777, 
  } ->
    
  # Apply Acme Air specific Configuration
  file { "${liberty::variables::deploymentconfig}":
        path     => "${liberty::variables::wxs_serverdir}/acmeair/server/config/${liberty::variables::deploymentconfig}",
        ensure   => file,
        #require => Package['liberty'],
        content  => template("liberty/${liberty::variables::deploymentconfig}.erb"),
        replace  => true,
  } ->
  file { "${liberty::variables::objectgridconfig}":
        path     => "${liberty::variables::wxs_serverdir}/acmeair/server/config/${liberty::variables::objectgridconfig}",
        ensure   => file,
        #require => Package['liberty'],
        content  => template("liberty/${liberty::variables::objectgridconfig}.erb"),
        replace  => true,
  } ->
  #setting java_home
  #exec {"setting java home":
  #  command => "export JAVA_HOME=/usr/lib/jvm/java-1.7.0",
  #  path    => "/opt/puppet/bin:${liberty::variables::install_root}/wlp/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
  # }->
  # Start the catalog server
  exec { "create_catalog_server":
    command     => "${liberty::variables::wxs_serverdir}/acmeair/runcat.sh &",
    path    => "${liberty::variables::path}",
    timeout     => 1800,
    environment => ["JAVA_HOME=${liberty::variables::java_home}"],
  } ->
    
  # Start the container server
  exec { "run_catalog_container":
    command     => "${liberty::variables::wxs_serverdir}/acmeair/runcontainer.sh c0 &",
    path    => "${liberty::variables::path}",
    timeout     => 1800,
    environment => ["JAVA_HOME=${liberty::variables::java_home}"],
  } ->
  
  #Sleep for the execs to complete. This is brittle  but these two  processes need to start.
  exec { "run_sleep":
    command     => "sleep 200",
    path    => "${liberty::variables::path}",
    #require =>  Liberty::Setup_acmeair['create_catalog_server'],
    #subscribe => Liberty::Setup_acmeair['run_catalog_container']
  } ->

  # load data into extreme scale
  exec { "load_data":
    command     => "java -cp ${liberty::variables::loader_class_path} com.acmeair.loader.Loader",
    path    => "${liberty::variables::path}",
    environment => ["JAVA_HOME=${liberty::variables::java_home}"],
  }

}