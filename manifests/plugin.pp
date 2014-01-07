# Installs the nagios plugin itself
# All  nagios plugins are installed this way
# Third-party ones may exist in a yum repo and are installed that way
#
# The templated plugins need the global variable 'monitoring_server'
# set as a fact.
#
# To see how to set it up for your infrastructure, see
# http://docs.puppetlabs.com/guides/custom_facts.html
define nagios::plugin () {
  $templated_plugins = [
    'check_kernel_passive',
    'check_nagios_config_passive',]

  $is_templated = member($templated_plugins, $title)
  $defaults = {
    alias   => $title,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    seltype => 'nagios_services_plugin_exec_t',
    require => Package['nrpe', 'nagios-plugins'],
  }
  $filename = "/usr/${::lib_path}/nagios/plugins/${title}"

  if $is_templated == true {
    $plugin = {
      "${filename}" => {
        content => template("${module_name}/plugins/${title}.erb"),
      }
    }
  } else {
    $plugin = {
      "${filename}" => {
        source => "puppet:///modules/nagios/plugins/${title}",
      }
    }
  }
  create_resources('file', $plugin, $defaults)
}
