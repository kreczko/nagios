##
# Sets up the Nagios servicegroups for your monitoring.
# Servicegroups need a name, an alias and a tag. That's it.
# tag should correspond to $::domain
class nagios::config::servicegroups (
  $additional_servicegroups = {
    'cpu' => {
      alias => 'CPU',
      tag   => $::domain,
    }
  }
  ,
  $servicegroup_tag         = $::domain,) {
  # create default service groups
  nagios_servicegroup { 'mysql':
    alias => 'MySQL',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'dhcp':
    alias => 'DHCP',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'dns':
    alias => 'DNS',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'uptime':
    alias => 'Uptime',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'network':
    alias => 'Network',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'memory':
    alias => 'Memory',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'cpu':
    alias => 'CPU',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'load':
    alias => 'Load',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'httpd':
    alias => 'HTTPD',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'kernel':
    alias => 'Kernel',
    tag   => $servicegroup_tag,
  }

  nagios_servicegroup { 'selinux':
    alias => 'SELinux',
    tag   => $servicegroup_tag,
  }

  # create additional service groups
  create_resources('nagios_servicegroup', $additional_servicegroups)
}
