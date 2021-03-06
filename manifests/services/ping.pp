# ### PING
class nagios::services::ping {
  @@nagios_service { "check_ping_${::fqdn}":
    check_command       => 'check_ping',
    host_name           => $::fqdn,
    service_description => 'Ping',
    use                 => '1min-service',
    tag                 => $::domain,
  }

  if ($::ipaddress6) {
    @@nagios_service { "check_ping_v6_${::fqdn}":
      check_command       => "check_ping_v6!${::ipaddress6}",
      host_name           => $::fqdn,
      service_description => 'Ping IPv6',
      use                 => '1min-service',
      tag                 => $::domain,
    }
  }
}
