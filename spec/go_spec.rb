describe 'mikoi::go' do
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

  it { is_expected.to include_recipe('golang') }

  it { is_expected.to install_golang_package('github.com/nabeken/mikoi') }

  it do
    is_expected.to create_link('/usr/local/bin/mikoi')
      .with_to('/opt/go/bin/mikoi')
  end
end
