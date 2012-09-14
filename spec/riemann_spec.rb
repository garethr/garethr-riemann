require_relative 'spec_helper'

describe 'riemann', :type => :class do
  it { should include_class('riemann::params') }
  it { should include_class('riemann::package') }
  it { should include_class('riemann::config') }
  it { should include_class('riemann::service') }
  it { should contain_class('wget')}
  it { should contain_file('/etc/riemann.sample.config') }
  it { should contain_file('/etc/puppet/riemann.yaml') }
  it { should contain_service('riemann').with_provider('upstart')}

  context "On a Debian OS with no package name specified" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it {
      should contain_package('leiningen')
      should contain_package('clojure1.3')
    }
  end

  context 'passing a version number' do
    let(:params) { {'version' => '1.0.0'} }
    it { should contain_exec('untar_riemann').with_creates("/opt/riemann-1.0.0")}
  end

  context 'passing a config file' do
    let(:params) { {'config_file' => '/etc/bob/riemann.config'} }
    it { should contain_file('/etc/init/riemann.conf').with_content(/bob/)}
  end

end
