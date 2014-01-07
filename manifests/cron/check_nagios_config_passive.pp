# Passive Nagios test for Nagios config
class nagios::cron::check_nagios_config_passive {
  cron { 'check_nagios_config_passive_hourly':
    ensure      => present,
    environment => ['PATH="/usr/sbin:/usr/bin:/sbin:/bin"'],
    command     => '/usr/lib64/nagios/plugins/check_nagios_config_passive',
    user        => root,
    hour        => '*',
    minute      => 0,
    month       => '*',
    weekday     => '*',
    require     => File['check_nagios_config'],
  }
}
