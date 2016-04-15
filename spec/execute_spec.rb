describe 'mikoi::execute' do
  let(:hostname) { '10.0.2.2' }
  let(:port) { '8080' }
  let(:proxy_protocol) { true }
  let(:install_dir) { '/usr/local/bin' }
  let(:mikoi) { File.join(install_dir, 'mikoi') }
  let(:execute_attributes) do
    {
      name => {
        hostname: hostname,
        port: port,
        proxy_protocol: proxy_protocol,
        command: curl_command
      }
    }
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['mikoi_execute']) do |node|
      node.set.mikoi.install_dir = install_dir
      node.set.mikoi.execute = execute_attributes
    end.converge(described_recipe)
  end
  subject { cached_run }

  shared_examples 'runs mikoi_execute' do
    it do
      is_expected.to run_mikoi_execute(name)
        .with_hostname(hostname)
        .with_port(port)
        .with_proxy_protocol(proxy_protocol)
        .with_command(curl_command)
    end

    it 'runs the inline execute' do
      is_expected.to run_execute("mikoi_execute inline #{name}")
        .with_command(inline_command)
    end
  end

  context 'with string command' do
    let(:mikoi_command) do
      "#{mikoi} --hostname #{hostname} --port #{port} --proxyproto --"
    end
    let(:curl_command) do
      %(curl -f -s -H 'Host: example.com' 'localhost:{}/test')
    end
    let(:inline_command) do
      "#{mikoi_command} #{curl_command}"
    end
    let(:name) { 'test with string command' }

    cached(:cached_run) { chef_run }

    include_examples 'runs mikoi_execute'
  end

  context 'with array command' do
    let(:mikoi_command) do
      [
        mikoi,
        '--hostname', hostname,
        '--port', port,
        '--proxyproto',
        '--'
      ]
    end
    let(:curl_command) do
      [
        'curl',
        '-f', '-s',
        '-H', 'Host: example.com',
        'localhost:{}/test'
      ]
    end
    let(:inline_command) { mikoi_command + curl_command }
    let(:name) { 'test with array command' }

    cached(:cached_run) { chef_run }

    include_examples 'runs mikoi_execute'
  end

  context 'with array command including explicit argv0' do
    let(:curl_command) do
      [
        ['curl', 'curl test argv0'],
        '-f', '-s',
        '-H', 'Host: example.com',
        'localhost:{}/test'
      ]
    end
    let(:inline_command) do
      [
        [mikoi, 'curl test argv0'],
        '--hostname', hostname,
        '--port', port,
        '--proxyproto',
        '--',
        'curl',
        '-f', '-s',
        '-H', 'Host: example.com',
        'localhost:{}/test'
      ]
    end
    let(:name) { 'test with array command including explicit argv0' }

    cached(:cached_run) { chef_run }

    include_examples 'runs mikoi_execute'
  end
end
