describe 'mikoi::default' do
  context 'with release install method' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set.mikoi.install_method = 'release'
      end.converge(described_recipe)
    end

    cached(:cached_run) { chef_run }
    subject { cached_run }

    it { is_expected.to include_recipe('mikoi::release') }
  end

  context 'with go install method' do
    let(:go_version) { '1.5.3' }
    before do
      stub_command(%(/usr/local/go/bin/go version | grep "go#{go_version} "))
        .and_return(true)
    end

    cached(:cached_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set.mikoi.install_method = 'go'
        node.set.go.version = go_version
      end.converge(described_recipe)
    end
    subject { cached_run }

    it { is_expected.to include_recipe('mikoi::go') }
  end
end
