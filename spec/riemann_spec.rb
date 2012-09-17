require_relative 'spec_helper'

describe 'riemann', :type => :class do
  it { should include_class('riemann::params') }
  it { should include_class('riemann::package') }
  it { should include_class('riemann::config') }
  it { should include_class('riemann::service') }
  it { should contain_class('wget')}
  it { should contain_file('/etc/riemann.sample.config') }
  it { should contain_file('/etc/puppet/riemann.yaml') }

  context "On a Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_service('riemann').with_provider('upstart')}
    it {
      should contain_package('leiningen')
      should contain_package('clojure1.3')
    }
  end

  context "On a Redhat OS" do
    let :facts do
      {
        :osfamily => 'Redhat'
      }
    end

    it { should include_class('epel') }
    it { should contain_package('clojure') }
    it { should contain_service('riemann').with_provider('redhat')}
  end

  context 'passing a version number' do
    let(:params) { {'version' => '1.0.0'} }
    it { should contain_exec('untar_riemann').with_creates("/opt/riemann-1.0.0")}
  end

  context 'passing a config file on Debian' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    let(:params) { {'config_file' => '/etc/bob/riemann.config'} }
    it { should contain_file('/etc/init/riemann.conf').with_content(/bob/)}
  end

  context 'passing a config file on Redhat' do
    let :facts do
      {
        :osfamily => 'Redhat'
      }
    end

    let(:params) { {'config_file' => '/etc/bob/riemann.config'} }
    it { should contain_file('/etc/init.d/riemann').with_content(/bob/)}
  end
end
