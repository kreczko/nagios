# A nagios check to monitor the nagios service
# Problably only useful if >1 nagios server
# Chicken <=> Egg, anyone?
class nagios::services::nagios {
  # ### NAGIOS SERVICE
  $check_nagios = 'check_nagios!/var/log/nagios/nagios.log!/usr/sbin/nagios'
  @@nagios_service { "check_nagios_${::fqdn}":
    check_command       => $check_nagios,
    host_name           => $::fqdn,
    service_description => 'Nagios',
    use                 => '5min-service',
    tag                 => $::domain,
  }

  # ### NAGIOS STATS
  @@nagios_service { "check_nagiostats_${::fqdn}":
    check_command       => 'check_nagiostats',
    host_name           => $::fqdn,
    service_description => 'Nagios stats',
    use                 => '5min-service',
    tag                 => $::domain,
  }

  # ### NAGIOS CONFIG
  # Check the config every time Nagios is restarted
  exec { 'check_nagios_config_passive':
    command     => '/usr/lib64/nagios/plugins/check_nagios_config_passive',
    refreshonly => true,
    subscribe   => Service['nagios'],
  }

  # Also run the check every hour, so the passive check can't get stale
  include nagios::cron::check_nagios_config_passive

  # Passive Nagios service definition for the above
  $check_dummy = 'check_dummy!1 "No passive checks for at least 48h"'
  @@nagios_service { "check_nagios_config_${::fqdn}":
    host_name             => $::fqdn,
    service_description   => 'Nagios config',
    use                   => '5min-service',
    active_checks_enabled => 0,
    max_check_attempts    => 1,
    check_freshness       => 1,
    freshness_threshold   => 172800,
    check_command         => $check_dummy,
    tag                   => $::domain,
  }
}
