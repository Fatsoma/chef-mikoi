#
# Cookbook Name:: mikoi
# Recipe:: default
#

include_recipe 'golang'

golang_package 'github.com/nabeken/mikoi'

link File.join(node['mikoi']['install_dir'], 'mikoi') do
  to File.join(node['go']['gobin'], 'mikoi')
end
