#
# Cookbook Name:: mikoi
# Recipe:: release
#

release_directory = File.join(Chef::Config[:file_cache_path], 'mikoi', node['mikoi']['version'])
release_url = node['mikoi']['release_url'] ||
              node['mikoi']['release_url_template']
                  .gsub('{version}', node['mikoi']['version'])
                  .gsub('{release_file}', node['mikoi']['release_file'])
extracted_path = File.join(release_directory, node['mikoi']['release_file'].sub(/\..*$/, ''))

directory release_directory do
  mode '0755'
  recursive true
end

remote_file File.join(release_directory, node['mikoi']['release_file']) do
  source release_url
  mode '0644'
  action :create_if_missing
end

if node['mikoi']['release_file'].end_with?('.zip')
  execute 'extract mikoi' do
    cwd release_directory
    command "unzip #{node['mikoi']['release_file']}"
    creates extracted_path
  end
elsif node['mikoi']['release_file'].end_with?('.tar.gz')
  execute 'extract mikoi' do
    cwd release_directory
    command "tar xzf #{node['mikoi']['release_file']}"
    creates extracted_path
  end
end

execute 'install mikoi binary' do
  command "cp '#{File.join(extracted_path, 'mikoi')}' '#{File.join(node['mikoi']['install_dir'], 'mikoi')}'"
  creates File.join(node['mikoi']['install_dir'], 'mikoi')
end
