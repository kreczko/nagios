define nagios::plugins::iostat (
  $warning  = '50000',
  $critical = '100000',) {
  $iostat_params = "-c ${critical},${critical},${critical} -w ${warning},${warning},${warning}"

  nagios::config::nrpe { "check_iostat_${name}":
    command => "check_iostat -d ${name} ${iostat_params}",
  }
}
