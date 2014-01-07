# Creating virtual hosts for the Nagios server
# Currently only the CAS authentication method is supported
class nagios::config::vhosts (
  $use_mod_auth_cas = true,
  $cas_login_url    = undef,
  $cas_users        = [],
  $cas_validate_url = undef,) {
  # since puppetlabs/apache does not support mod_cas, we need to manually create
  # this file
  if $use_mod_auth_cas == true {
    file { '/etc/httpd/conf.d/00-cas_auth.conf':
      alias     => '00-cas_auth.conf',
      content   => template("${module_name}/00-cas_auth.conf.erb"),
      subscribe => Service['httpd']
    }
  }
  $allowed_users = join($cas_users, ' ')

  # apache config for nagios
  file { '/etc/httpd/conf.d/25-Nagios.conf':
    alias     => '25-Nagios.conf',
    content   => template("${module_name}/25-Nagios.conf.erb"),
    subscribe => Service['httpd']
  }

  # apache configuration for pnp4nagios
  file { '/etc/httpd/conf.d/35-PNP4Nagios.conf':
    alias     => '35-PNP4Nagios.conf',
    content   => template("${module_name}/35-PNP4Nagios.conf.erb"),
    subscribe => Service['httpd']
  }

  # Remove stock nagios and pnp configs because they don't work
  # They will be replaced when the RPM is upgraded so keep this block
  file { ['/etc/httpd/conf.d/nagios.conf', '/etc/httpd/conf.d/pnp4nagios.conf']:
    ensure  => absent,
    require => Package['httpd', 'nagios'],
  }
}
