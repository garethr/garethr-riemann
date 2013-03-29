require 'spec_helper'

describe 'riemann::tools', :type => :class do
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
end
