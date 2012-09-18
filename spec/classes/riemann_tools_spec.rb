require 'spec_helper'

describe 'riemann::tools', :type => :class do
  it { should contain_package('riemann-tools').with_provider('gem')}
  it { should contain_package('riemann-client').with_provider('gem')}

  context 'on debian with services disabled' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    let(:params) { {'health_enabled' => false, 'net_enabled' => false} }
    it { should contain_service('riemann-net').with_provider('upstart').with_enable(false)}
    it { should contain_service('riemann-health').with_provider('upstart').with_enable(false)}
  end

  context 'on debian with services enabled' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_service('riemann-net').with_provider('upstart')}
    it { should contain_service('riemann-health').with_provider('upstart')}
  end

  context 'on redhat with services disabled' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    let(:params) { {'health_enabled' => false, 'net_enabled' => false} }
    it { should contain_service('riemann-net').with_provider('redhat').with_enable(false)}
    it { should contain_service('riemann-health').with_provider('redhat').with_enable(false)}
  end

  context 'with services enabled' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it { should contain_service('riemann-net').with_provider('redhat')}
    it { should contain_service('riemann-health').with_provider('redhat')}
  end
end
