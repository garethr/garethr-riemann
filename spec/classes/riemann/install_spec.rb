require 'spec_helper'

describe 'riemann::install', :type => :class do
  it { should contain_wget__fetch('download_riemann')}
  it { should contain_exec('untar_riemann')}
end
