# Nagios Commands
class nagios::commands {
  nagios_command { 'check_ftp':
    command_line => '$USER1$/check_ftp -H $HOSTADDRESS$ $ARG1$',
  }

  $host_email = '***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n'
  $host_subject = '"** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **"'
  $host_sendmail = "/bin/mail -s ${host_subject}"
  nagios_command { 'notify-host-by-email':
    command_line => "/usr/bin/printf \"%b\" \"${host_email}\" | ${host_sendmail}",
  }

  $service_email = '***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$'
  $service_subject = '"** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **"'
  $service_sendmail = "/bin/mail -s ${service_subject}"

  nagios_command { 'notify-service-by-email':
    command_line => "/usr/bin/printf \"%b\" \"${service_email}\" | ${service_sendmail}",
  }

  nagios_command { 'check-host-alive':
    command_line => '$USER1$/check_ping -H $HOSTADDRESS$ -w 1000.0,20% -c 3000.0,90% -p 5',
  }

  nagios_command { 'check_local_disk':
    command_line => '$USER1$/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$',
  }

  nagios_command { 'check_local_load':
    command_line => '$USER1$/check_load -w $ARG1$ -c $ARG2$',
  }

  nagios_command { 'check_local_procs':
    command_line => '$USER1$/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$',
  }

  nagios_command { 'check_local_users':
    command_line => '$USER1$/check_users -w $ARG1$ -c $ARG2$',
  }

  nagios_command { 'check_local_swap':
    command_line => '$USER1$/check_swap -w $ARG1$ -c $ARG2$',
  }

  nagios_command { 'check_local_mrtgtraf':
    command_line => '$USER1$/check_mrtgtraf -F $ARG1$ -a $ARG2$ -w $ARG3$ -c $ARG4$ -e $ARG5$',
  }

  nagios_command { 'check_hpjd':
    command_line => '$USER1$/check_hpjd -H $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_snmp':
    command_line => '$USER1$/check_snmp -H $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_http':
    command_line => '$USER1$/check_http -I $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_http_vhost':
    command_line => '$USER1$/check_http -H $ARG1$ -u $ARG2$',
  }

  nagios_command { 'check_http_vhost_ssl':
    command_line => '$USER1$/check_http -H $ARG1$ -S -u $ARG2$',
  }

  nagios_command { 'check_ssh':
    command_line => '$USER1$/check_ssh $ARG1$ $HOSTADDRESS$',
  }

  nagios_command { 'check_dhcp':
    command_line => '$USER1$/check_dhcp $ARG1$',
  }

  nagios_command { 'check_ping':
    command_line => '$USER1$/check_ping -H $HOSTADDRESS$ -w 100,10% -c 1000,50% -p 5',
  }

  nagios_command { 'check_ping_v6':
    command_line => '$USER1$/check_ping -H $ARG1$ -w 100,10% -c 1000,50% -p 5 -6',
  }

  nagios_command { 'check_pop':
    command_line => '$USER1$/check_pop -H $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_imap':
    command_line => '$USER1$/check_imap -H $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_smtp':
    command_line => '$USER1$/check_smtp -H $HOSTADDRESS$ $ARG1$',
  }

  nagios_command { 'check_tcp':
    command_line => '$USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
  }

  nagios_command { 'check_udp':
    command_line => '$USER1$/check_udp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
  }

  nagios_command { 'check_nt':
    command_line => '$USER1$/check_nt -H $HOSTADDRESS$ -p 12489 -v $ARG1$ $ARG2$',
  }

  nagios_command { 'check_mysql':
    command_line => '$USER1$/check_mysql -d $ARG1$ -H $HOSTADDRESS$ -P 3306 -u $ARG2$ -p $ARG3$',
  }

  nagios_command { 'check_dns':
    command_line => '$USER1$/check_dns -H $ARG1$ -s $HOSTADDRESS$ -w $ARG2$',
  }

  nagios_command { 'check_nrpe':
    command_line => '$USER1$/check_nrpe -u -H $HOSTADDRESS$ -t 20 -c $ARG1$',
  }

  nagios_command { 'check_nrpe_gz_b64':
    command_line => '$USER1$/check_nrpe_gz_b64_server -u -H $HOSTADDRESS$ -t 20 -c $ARG1$',
  }

  nagios_command { 'check_nrpe_status':
    command_line => '$USER1$/check_nrpe -H $HOSTADDRESS$',
  }

  nagios_command { 'check_ntp_time':
    command_line => '$USER1$/check_ntp_time -H $HOSTADDRESS$',
  }

  nagios_command { 'check_disk':
    command_line => '$USER1$/check_disk -w $ARG1$ -c $ARG2$ $ARG3$',
  }

  nagios_command { 'check_kernel':
    command_line => '$USER1$/check_kernel',
  }

  nagios_command { 'check_yum':
    command_line => '$USER1$/check_yum --all-updates',
  }

  nagios_command { 'check_daemons':
    command_line => '$USER1$/check_daemons $ARG1$',
  }

  nagios_command { 'check_legato':
    command_line => '$USER1$/check_legato',
  }

  nagios_command { 'check_wbinfo':
    command_line => '$USER1$/check_wbinfo',
  }

  nagios_command { 'check_eapol':
    command_line => '$USER1$/check_eapol $HOSTADDRESS$ $ARG1$ $ARG2$',
  }

  nagios_command { 'check_vnetradius':
    command_line => '$USER1$/check_vnetradius $HOSTADDRESS$ $ARG1$ $ARG2$',
  }

  nagios_command { 'check_noneapradius':
    command_line => '$USER1$/check_noneapradius $HOSTADDRESS$ $ARG1$ $ARG2$ $USER1$/$ARG3$',
  }

  nagios_command { 'check_consoles':
    command_line => '$USER1$/check_consoles $HOSTADDRESS$',
  }

  nagios_command { 'check_ntlm':
    command_line => '$USER1$/check_ntlm USER0 PASSWORD',
  }

  nagios_command { 'check_uptime':
    command_line => '$USER1$/check_uptime',
  }

  nagios_command { 'check_esx':
    command_line => '$USER1$/check_esx https://$HOSTADDRESS$ $ARG1$ $ARG2$',
  }

  nagios_command { 'check_nagios':
    command_line => '$USER1$/check_nagios -F $ARG1$ -e 10 -C $ARG2$',
  }

  nagios_command { 'check_smb':
    command_line => '$USER1$/check_smb -H $HOSTADDRESS$',
  }

  nagios_command { 'process-service-perfdata':
    command_line => '/usr/bin/perl /usr/libexec/pnp4nagios/process_perfdata.pl',
  }

  nagios_command { 'process-host-perfdata':
    command_line => '/usr/bin/perl /usr/libexec/pnp4nagios/process_perfdata.pl -d HOSTPERFDATA',
  }

  nagios_command { 'process-service-perfdata-file':
    command_line => '/bin/echo 0 > /tmp/service-perfdata',
  }

  nagios_command { 'process-host-perfdata-file':
    command_line => '/bin/echo 0 > /tmp/host-perfdata',
  }

  nagios_command { 'check_mysql_replication':
    command_line => '$USER1$/check_mysql_all -K repl_all -H $HOSTADDRESS$ -u $ARG1$ -p $ARG2$',
  }

  nagios_command { 'check_mysql_tables':
    command_line => '$USER1$/check_mysql_all -K table_status -H $HOSTADDRESS$ -u $ARG1$ -p $ARG2$',
  }

  nagios_command { 'check_mysql_connections':
    command_line => '$USER1$/check_mysql_all -K connections -H $HOSTADDRESS$ -u $ARG1$ -p $ARG2$',
  }

  nagios_command { 'check_reg_users':
    command_line => '$USER1$/check_reg_users',
  }

  nagios_command { 'check_reg_consoles':
    command_line => '$USER1$/check_reg_consoles',
  }

  nagios_command { 'check_apache':
    command_line => '$USER1$/check_apache -H $HOSTADDRESS$',
  }

  nagios_command { 'check_esx_cpu':
    command_line => '$USER1$/check_esx_cpu -h $HOSTADDRESS$ -u rnnagios -p TEST-w 80 -c 90 -f',
  }

  nagios_command { 'check_esx_memory':
    command_line => '$USER1$/check_esx_memory -h $HOSTADDRESS$ -u rnnagios -p TEST -w 80 -c 90 -f',
  }

  nagios_command { 'check_esx_hardware':
    command_line => '$USER1$/check_esx_hardware -H $HOSTADDRESS$ -u rnnagios -p TEST -l $ARG1$',
  }

# Currently disabled as plugin is needs to be redesigned
#  nagios_command { 'check_puppet_checkin_db':
#    command_line => '$USER1$/check_puppet_checkin_db $HOSTNAME$',
#  }

  nagios_command { 'check_nagiostats':
    command_line => '$USER1$/check_nagiostats --EXEC /usr/bin/nagiostats',
  }

  nagios_command { 'check_dummy':
    command_line => '$USER1$/check_dummy $ARG1$',
  }

  nagios_command { 'check_radius_status':
    command_line => '$USER1$/check_radius_status $HOSTADDRESS$ 18120',
  }

  nagios_command { 'check_mysql_visitornet':
    command_line => '$USER1$/check_mysql_visitornet',
  }

  nagios_command { 'check_aaaa':
    command_line => '$USER1$/check_aaaa $HOSTNAME$',
  }
}
