# Nagios plugins and config for checking nagios servers
class nagios::plugins::nagios ($nagios_host = $::fqdn) {
  # check_nagios_config
  nagios::plugin { 'check_nagios_config': }

  nagios::config::nrpe { 'check_nagios_config': command => 'check_nagios_config',
  }
  User <| title == 'nrpe' |> {
    groups +> 'nagios'
  }

  # check_nagiostats
  nagios::plugin { 'check_nagiostats': }

  nagios::config::nrpe { 'check_nagiostats': command => 'check_nagiostats', }
}
