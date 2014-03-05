# Configuration for Nagios client
class nagios::config::client (
  $allowed_hosts = ['127.0.0.1'],
  $hostgroups    = undef,) {
  if $hostgroups == undef {
    # try and guess the correct group
    $local_hostgroups = $::hostname ? {
      /^dhcp\d+/   => 'dhcp-servers',
      /^dns\d+/    => 'dns-servers',
      /^web\d+/    => 'web-servers',
      /^webdev/    => 'dev-servers',
      /^build\d+/  => 'dev-servers',
      /^db\d+/     => 'db-servers',
      /^syslog\d+/ => 'syslog-servers',
      default      => undef,
    } } else {
    $local_hostgroups = $hostgroups
  }

  # Define the host in nagios, including parent hypervisor, if there is one

  @@nagios_host { $::fqdn:
    ensure     => present,
    address    => $::ipaddress,
    use        => 'generic-host',
    tag        => $::domain,
    # Insert parent value if we are a VM
    parents    => $::vmparent,
    action_url => "/nagios/pnp4nagios/graph?host=${::fqdn}",
    hostgroups => $local_hostgroups,
  }

  # If we are a virtual host, also add host deps on parent
  # If we don't (yet) know the parent, skip this step for now
  # This suppresses warnings for VMs if the hypervisor is down
  if ($::virtual == 'kvm') and ($::vmparent) {
    @@nagios_hostdependency { "${::fqdn}-${::vmparent}":
      host_name                     => $::vmparent,
      dependent_host_name           => $::fqdn,
      notification_failure_criteria => 'd,u',
    }
  }

  # Add icons for the OS and graphs
  @@nagios_hostextinfo { $::fqdn:
    ensure          => present,
    icon_image_alt  => $::operatingsystem,
    icon_image      => "${::operatingsystem}.png",
    statusmap_image => "${::operatingsystem}.gd2",
    tag             => $::domain,
  }

  # Install base nrpe config
  file { '/etc/nagios/nrpe.cfg':
    ensure  => present,
    mode    => '0644',
    owner   => 'nrpe',
    group   => 'nrpe',
    content => template('nagios/nrpe.cfg.erb'),
    require => Package['nrpe'],
    notify  => Service['nrpe'],
  }

  # install base send_nsca.cfg
  file {'/etc/nagios/send_nsca.cfg':
    ensure => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source => 'puppet:///modules/nagios/send_nsca.cfg',
    require => Package['nsca-client'],
  }

  # Add a symlink for the different path on ubuntu
  if $::osfamily == 'Debian' {
    file { '/etc/nrpe.d':
      ensure => link,
      target => '/etc/nagios/nrpe.d',
    }
  }

  # Auto-add a NSCA firewall rule on the monitor server just for us
  @@firewall { "200-nsca-${::fqdn}":
    proto  => 'tcp',
    dport  => '5667',
    tag    => 'nsca',
    source => $::ipaddress,
    action => 'accept',
  }

  @@firewall { "200-nsca-v6-${::fqdn}":
    proto    => 'tcp',
    dport    => '5667',
    source   => $::ipaddress6,
    provider => 'ip6tables',
    action   => 'accept',
  }

  # Add a VIRTUAL nrpe user
  @user { 'nrpe':
    ensure  => present,
    require => Package['nrpe'],
  }

  # Add a VIRTUAL nagios user (should be created by nagios package)
  @user { 'nagios':
    ensure  => present,
    require => Package['nagios-plugins-all'],
  }

  # Then realize that virtual user with collection syntax
  User <| title == 'nrpe' |>

  # Elsewhere add to the parameters for that virtual resource using plusignment
  User <| title == 'nrpe' |> {
    groups +> 'puppet'
  }

  # Add firewall rule to allow NRPE from the monitoring server
  Firewall <<| tag == 'nrpe' |>>
}
