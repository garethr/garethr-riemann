require 'spec_helper'

describe 'riemann::dash', :type => :class do
  it { should include_class('riemann::dash::package')}
  it { should include_class('riemann::dash::service')}
  it { should contain_package('riemann-dash')}

  context "On Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_service('riemann-dash').with_provider('upstart')}
  end

  context "On RedHat OS" do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it { should contain_service('riemann-dash').with_provider('redhat')}
  end

  context 'on debian with custom dashboard configuration' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end
    let(:params) { {'config_file' => '/etc/bob.rb'} }
    it { should contain_file('/etc/init/riemann-dash.conf').with_content(/bob.rb/)}
  end

  context 'on redhat with custom dashboard configuration' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end
    let(:params) { {'config_file' => '/etc/bob.rb'} }
    it { should contain_file('/etc/init.d/riemann-dash').with_content(/bob.rb/)}
  end

end
