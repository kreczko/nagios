# Class: nagios
#
# This module manages nagios
#
# Parameters:
#
# allowed_hosts: a list of hosts which can connect to the Nagios client. Usually
# the monitoring server + localhost.
#
# is_server: boolean to determine the set up.
# True = server set up, false = client
#
# admins: hash of contacts for Nagios email warnings
#
# hostgroups: definition of groups for ordering hosts
#
# additional_servicegroups defines additional service groups which are not used
# by default. An example:
# $additional_servicegroups = 'cpu' => {
#      alias => 'CPU',
#      tag   => $::domain,
#    },
#
# use_mod_auth_cas: turn on mod_cas authentication. Currently the only supported
# authentication.
#
# cas_login_url: URL used for login within mod_cas
#
# cas_users: user names that are allowed to access the Nagios pages via mod_cas
#
# cas_validate_url: URL used for validation within  mod_cas
#
#
# Requires: see Modulefile
#
class nagios (
  $allowed_hosts            = ['127.0.0.1'],
  $is_server                = false,
  $admins                   = {
    'admin01' => {
      contact_name => 'admin01',
      alias        => 'Admin for life',
      email        => 'admin01@bristol.ac.uk',
    }
  }
  ,
  $hostgroups               = {
    'default' => {
      alias => 'default-hostgroup',
      tag   => $::domain,
    }
  }
  ,
  $additional_servicegroups = {
  }
  ,
  $use_mod_auth_cas         = true,
  $cas_login_url            = undef,
  $cas_users                = [],
  $cas_validate_url         = undef,
  $ensure                   = installed,
  $nagios_server            = $::fqdn,) {
  if $is_server == true {
    class { 'nagios::install':
      is_server => true,
      ensure    => $ensure,
    }

    class { 'nagios::config::server':
      allowed_hosts    => $allowed_hosts,
      admins           => $admins,
      hostgroups       => $hostgroups,
      servicegroups    => $additional_servicegroups,
      use_mod_auth_cas => $use_mod_auth_cas,
      cas_login_url    => $cas_login_url,
      cas_users        => $cas_users,
      cas_validate_url => $cas_validate_url,
    }

    # A server is also a client
    class { 'nagios::services::client':
    }

    # add nagios checks
    class { 'nagios::services::nagios':
    }

    # Start the Nagios service, and make it restart if there have been changes
    # to
    # the config
    service { 'nagios':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => false,
      require    => [Package['nagios'], File['nagios.cfg']],
    }

    # NSCA service to accept passive checks
    service { 'nsca':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => [Service['nagios'], Package['nsca'], File['nsca.cfg']],
    }

    Class['nagios::install'] -> Class['nagios::config::server'] ->
    Service['nagios'] -> Service['nsca']
  } else {
    class { 'nagios::install': ensure => $ensure, }

    class { 'nagios::config::client': allowed_hosts => $allowed_hosts, }

    class { 'nagios::services::client': }

    Class['nagios::install'] -> Class['nagios::config::client'] ->
    Class['nagios::services::client']
  }

}
