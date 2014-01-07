[x] ~~groupadd sudoers (or change group name)~~ fix file permissions
[x] add mod_auth_case configuration file (default apache module does not handle mod_auth_cas)
[] nagios::client mvparent and virtual are very custom values at the moment
[x] enable PHP for Nagios (or whatever is causing the problem)
[] fix problem of hostdependencies if none are existent: make nagios.cfg into a template!!
[] documentation: for host dependencies to work, both have to be Nagios clients!
[x] nrpe config: needs to be a template to include the Nagios server IPs (in our case 1 public and 1 private)
[x] add ~~vhost for~~ pnp4nagios configuration template
[x] install missing perl nagios plugins (yum install perl-Nagios-Plugin)
[x] install passive checks as cron jobs
[] add send_nsca.cfg for server
[] fix differences between /usr/lib64/nagios/plugins/check_nagios_config and /usr/lib64/nagios/plugins/check_nagios_config_passive
