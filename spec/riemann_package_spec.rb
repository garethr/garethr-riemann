require_relative 'spec_helper'

describe 'riemann::package', :type => :class do
  let(:params) { {'version' => '0.1.2'} }
  it { should contain_wget__fetch('download_riemann')}
  it { should contain_exec('untar_riemann').with_creates("/opt/riemann-0.1.2")}
end
