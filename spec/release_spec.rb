describe 'mikoi::release' do
  shared_examples 'release install' do
    it 'creates directory for release archive' do
      is_expected.to create_directory(release_directory)
        .with_recursive(true)
    end

    it 'downloads release archive' do
      is_expected.to create_remote_file_if_missing(File.join(release_directory, release_file))
        .with_source(release_url)
        .with_mode('0644')
    end

    it 'extracts release archive' do
      is_expected.to run_execute('extract mikoi')
        .with_cwd(release_directory)
        .with_command("#{extract_command} #{release_file}")
    end

    it 'installs mikoi binary' do
      is_expected.to run_execute('install mikoi binary')
        .with_command("cp '#{File.join(extracted_path, 'mikoi')}' '#{File.join(install_dir, 'mikoi')}'")
    end
  end

  let(:file_cache_path) { '/var/chef/cache' }
  let(:mikoi_version) { 'arbitrary_version' }
  let(:install_dir) { '/usr/local/bin' }
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: platform,
      version: platform_version,
      file_cache_path: file_cache_path) do |node|
        node.normal['mikoi']['install_method'] = 'release'
        node.normal['mikoi']['version'] = mikoi_version
        node.normal['mikoi']['release_url_template'] = release_url_template
        node.normal['mikoi']['install_dir'] = install_dir
      end.converge(described_recipe)
  end
  let(:release_directory) do
    File.join(file_cache_path, 'mikoi', mikoi_version)
  end
  let(:release_url_template) do
    'https://github.com/nabeken/mikoi/releases/download/{version}/{release_file}'
  end
  let(:release_url) do
    release_url_template
      .gsub('{version}', mikoi_version)
      .gsub('{release_file}', release_file)
  end
  let(:extracted_path) do
    File.join(release_directory, release_file.sub(/\..*$/, ''))
  end
  let(:extract_command) { 'unzip' }

  subject { cached_run }

  context 'with os linux' do
    let(:platform) { 'ubuntu' }
    let(:platform_version) { '14.04' }
    let(:release_file) { 'mikoi_linux_amd64.tar.gz' }
    let(:extract_command) { 'tar xzf' }
    cached(:cached_run) { chef_run }

    it { expect(cached_run.node['os']).to eq('linux') }
    include_examples 'release install'
  end

  context 'with os darwin' do
    let(:platform) { 'mac_os_x' }
    let(:platform_version) { '10.11.1' }
    let(:release_file) { 'mikoi_darwin_amd64.zip' }
    cached(:cached_run) { chef_run }

    it { expect(cached_run.node['os']).to eq('darwin') }
    include_examples 'release install'
  end

  context 'with os freebsd' do
    let(:platform) { 'freebsd' }
    let(:platform_version) { '10.2' }
    let(:release_file) { 'mikoi_freebsd_amd64.zip' }
    cached(:cached_run) { chef_run }

    it { expect(cached_run.node['os']).to eq('freebsd') }
    include_examples 'release install'
  end

  context 'with os windows' do
    let(:platform) { 'windows' }
    let(:platform_version) { '2012R2' }
    let(:release_file) { 'mikoi_windows_386.zip' }
    cached(:cached_run) { chef_run }

    it { expect(cached_run.node['os']).to eq('windows') }
    include_examples 'release install'
  end
end
