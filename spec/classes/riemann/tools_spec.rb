require 'spec_helper'

describe 'riemann::tools', :type => :class do
  let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'precise'} }

  it { should contain_package('riemann-tools').with_provider('gem')}
  it { should contain_package('riemann-client').with_provider('gem')}

  context 'with services enabled' do
    let(:params) { {'health_enabled' => false, 'net_enabled' => false} }
    it { should contain_service('riemann-net').with_provider('upstart').with_enable(false)}
    it { should contain_service('riemann-health').with_provider('upstart').with_enable(false)}
  end

  context 'with services disabled' do
    it { should contain_service('riemann-net').with_provider('upstart')}
    it { should contain_service('riemann-health').with_provider('upstart')}
  end

  context 'passing invalid params' do
    let(:params) { { 'health_enabled' => 'invalid'} }
    it do
      expect {
        should contain_package('riemann-tools')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with an invalid operating system' do
    let(:facts) { {:osfamily => 'invalid'} }
    it do
      expect {
        should contain_package('riemann-tools')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'when running on RedHat/Centos' do
    let(:facts) { {:osfamily => 'RedHat'} }
    it { should include_class('epel') }
    it { should contain_file('/etc/init.d/riemann-net').with_mode('0755')}
    it { should contain_file('/etc/init.d/riemann-health').with_mode('0755')}
    it { should_not contain_file('/etc/init/riemann-net.conf')}
    it { should_not contain_file('/etc/init/riemann-health.conf')}
    it { should contain_service('riemann-net').with_provider('redhat')}
    it { should contain_service('riemann-health').with_provider('redhat')}
  end

end
