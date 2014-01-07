define nagios::plugins::tcp_traffic (
  $warning  = '75000000',
  $critical = '90000000',) {
  $command = "check_tcptraffic -i ${name} -s 1000 -w ${warning} -c ${critical}"

  nagios::config::nrpe { "check_tcptraffic_${name}": command => $command, }
}
