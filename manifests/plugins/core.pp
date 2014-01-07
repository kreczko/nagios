# Core Nagios plugins used on all servers
class nagios::plugins::core (
  $n_user_warning  = 5,
  $n_user_critical = 10,) {
  nagios::plugin { 'check_ads': }

  nagios::config::nrpe { 'check_ads':
    command => 'check_ads',
  }

  nagios::plugin { 'check_cpu': }

  nagios::config::nrpe { 'check_cpu': command => 'check_cpu', }

  nagios::plugin { 'check_daemons': }

  # IOSTAT

  package { 'sysstat': ensure => installed, }

  file { '/etc/cron.d/sysstat':
    ensure  => absent,
    require => Package['sysstat'],
  }

  nagios::plugin { 'check_iostat':
    require => Package['sysstat'],
  }

  $iostat_params = '-c 100000,100000,100000 -w 50000,50000,50000'
  nagios::config::nrpe { 'check_iostat_sda':
    command => "check_iostat -d sda ${iostat_params}",
  }

  nagios::config::nrpe { 'check_iostat_sdb':
    command => "check_iostat -d sdb ${iostat_params}",
  }

  nagios::config::nrpe { 'check_iostat_sdc':
    command => "check_iostat -d sdc ${iostat_params}",
  }

  nagios::config::nrpe { 'check_iostat_sdd':
    command => "check_iostat -d sdd ${iostat_params}",
  }

  nagios::plugin { 'check_kernel': }

  nagios::config::nrpe { 'check_kernel': command => 'check_kernel', }

  nagios::plugin { 'check_legato': }

  nagios::config::nrpe { 'check_networker': command => 'check_legato', }

  nagios::plugin { 'check_memory': }

  nagios::config::nrpe { 'check_memory':
    command => 'check_memory -w 20% -c 10%',
  }

  nagios::plugin { 'check_procs_perfdata': }

  nagios::config::nrpe { 'check_total_procs':
    command => 'check_procs_perfdata -w 300 -c 500',
  }

  nagios::plugin { 'check_uptime': }

  nagios::config::nrpe { 'check_uptime': command => 'check_uptime', }

  nagios::plugin { 'check_yum': }

  nagios::config::nrpe { 'check_yum': command => 'check_yum --all-updates', }

  nagios::plugin { 'check_selinux': }

  nagios::config::nrpe { 'check_selinux': command => 'check_selinux', }

  nagios::plugin { 'check_x509cert': }

  nagios::config::nrpe { 'check_x509cert':
    command => 'check_x509cert -P /etc/grid-security/',
  }

  nagios::config::nrpe { 'check_x509cert_https':
    command => 'check_x509cert -P /etc/httpd/certs/',
  }

  # Load average depends on number of CPU cores
  $single = $::processorcount
  $double = $::processorcount * 2
  $triple = $::processorcount * 3
  $warnload = "${double},${single},${single}"
  $critload = "${triple},${double},${double}"

  # command => "check_load -w $warnload,$warnload,$warnload
  # -c $critload,$critload,$critload",
  nagios::config::nrpe   { 'check_load':
    command => "check_load -w ${warnload} -c ${critload}",
  }

  nagios::config::nrpe { 'check_disk_all':
    command => 'check_disk -l -x /dev/shm -w 10% -c 5%',
  }

  nagios::config::nrpe { 'check_smtp':
    command => 'check_smtp -H 127.0.0.1',
  }

  nagios::config::nrpe { 'check_zombie_procs':
    command => 'check_procs -w 20 -c 40 -s Z',
  }

  nagios::config::nrpe { 'check_swap':
    command => 'check_swap -w 50% -c 20%',
  }

  nagios::config::nrpe { 'check_users':
    command => 'check_users -w 5 -c 10',
  }

  nagios::config::nrpe { 'check_vmtoolsd':
    command => 'check_daemons vmtoolsd',
  }

  nagios::config::nrpe { 'check_crond': command => 'check_daemons crond', }

  nagios::config::nrpe { 'check_ntp': command => 'check_ntp -H localhost', }

  nagios::config::nrpe { 'check_mailq': command => 'check_mailq -w 5 -c 10', }

  $interfaces_array = split($::interfaces, ',')
  nagios::plugins::tcp_traffic { [$interfaces_array]: }

  nagios::config::nrpe { 'check_linux_bonding':
    command => 'check_linux_bonding',
  }

  nagios::config::nrpe { 'check_openmanage': command => 'check_openmanage', }

  nagios::config::nrpe { 'check_xinetd': command => 'check_daemons xinetd',}

  #TODO: add DNS host as parameter
  nagios::config::nrpe { 'check_dns':
    command => 'check_dns -H www.bris.ac.uk -s 127.0.0.1',
  }

  # This plugin is not run via NRPE, but actually via cron and NSCA
  nagios::plugin {'check_kernel_passive':}
}
