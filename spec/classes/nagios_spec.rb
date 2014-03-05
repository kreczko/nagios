require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nagios' do

  let(:title) { 'nagios' }
  let(:node) { 'testing.phy.bris.ac.uk' }
  # facts are either defined globally or separately after every
  # 'context/describe'
  let(:facts) { {
      :ipaddress => '10.13.37.100',
      :processorcount => 1,
      :osfamily => 'RedHat',
      :operatingsystem => 'Redhat',
      :operatingsystemrelease => '6.4',
      :concat_basedir         => '/dne',
    } }

  describe 'Test standard installation on RedHat (client)' do
    # packages
    it { should contain_package('nagios-plugins').with_ensure('installed') }
    it { should contain_package('nagios-plugins-all').with_ensure('installed') }
    it { should contain_package('nagios-plugins-perl').with_ensure('installed') }
    it { should contain_package('nagios-plugins-check-tcptraffic').with_ensure('installed') }
    it { should contain_package('perl-DateTime').with_ensure('installed') }
    it { should contain_package('nrpe').with_ensure('installed') }
    it { should contain_package('nsca-client').with_ensure('installed') }
    # services
    it { should contain_service('nrpe').with_ensure('running') }
    it { should contain_service('nrpe').with_enable('true') }
    # files
    it { should contain_file('/etc/nagios/nrpe.cfg').with({
        'ensure' => 'present',
        'owner'  => 'nrpe',
        'group'  => 'nrpe',
        'mode'   => '0644',
      })}
    # users
    it { should contain_user('nrpe') }
  end

  describe 'Test standard installation on RedHat (server)' do
    let(:params) { {:is_server => true } }
    # classes
    it { should contain_class('apache') }
    # packages
    it { should contain_package('nagios').with_ensure('installed') }
    it { should contain_package('pnp4nagios').with_ensure('installed') }
    it { should contain_package('nagios-plugins-nrpe').with_ensure('installed') }
    it { should contain_package('nsca').with_ensure('installed') }
    # services
    it { should contain_service('nagios').with_ensure('running') }
    it { should contain_service('nagios').with_enable('true') }
    it { should contain_service('httpd').with_ensure('running') }
    it { should contain_service('httpd').with_enable('true') }
    # files
    it {should contain_file('/etc/nagios/private/resource.cfg').with({
        'owner' => 'root',
        'group' => 'nagios',
        'mode' => '0640',
      })}
    it {should contain_file('/etc/nagios/nagios.cfg').with({
        'owner' => 'root',
        'group' => 'nagios',
        'mode' => '0640',
      })}
    it {should contain_file('/etc/nagios/nsca.cfg').with({
        'owner' => 'root',
        'group' => 'root',
        'mode' => '0600',
      })}
    it {should contain_file('/etc/nagios/cgi.cfg').with({
        'owner' => 'root',
        'group' => 'nagios',
        'mode' => '0640',
      })}
    # users
    # the apache user has to be in the nagios group
    it { should contain_user('apache').with({'group' => 'nagios'}) }
  end

end
