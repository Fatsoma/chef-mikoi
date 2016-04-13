require 'spec_helper'

context 'release install method' do
  let(:file_cache_path) { '/tmp/kitchen/cache' }
  let(:mikoi_version) { 'v20150613191746' }
  let(:release_directory) { File.join(file_cache_path, 'mikoi', mikoi_version) }
  let(:archive_path) { File.join(release_directory, archive_file) }
  let(:install_dir) { '/usr/local/bin' }

  def archive_file
    case RbConfig::CONFIG['host_os']
    when /darwin.+$/
      'mikoi_darwin_amd64.zip'
    when /linux/
      'mikoi_linux_amd64.tar.gz'
    when /freebsd.+$/
      'mikoi_freebsd_amd64.zip'
    when /mswin|mingw32|windows/
      'mikoi_windows_386.zip'
    else
      ''
    end
  end

  describe 'archive file' do
    subject { file(archive_path) }
    it { is_expected.to be_file }
  end

  describe 'installed mikoi binary' do
    subject { file(File.join(install_dir, 'mikoi')) }
    it { is_expected.to be_executable }
  end
end
