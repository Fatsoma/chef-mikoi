require 'spec_helper'

describe 'go install method' do
  let(:file_cache_path) { '/tmp/kitchen/cache' }
  let(:go_bin_path) { '/opt/go/bin' }
  let(:install_dir) { '/usr/local/bin' }

  describe 'mikoi go binary' do
    subject { file(File.join(go_bin_path, 'mikoi')) }
    it { is_expected.to be_executable }
  end

  describe 'mikoi local binary' do
    subject { file(File.join(install_dir, 'mikoi')) }
    it { is_expected.to be_executable }
  end
end
