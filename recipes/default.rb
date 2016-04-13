#
# Cookbook Name:: mikoi
# Recipe:: default
#

case node.mikoi.install_method
when 'release'
  include_recipe 'mikoi::release'
when 'go'
  include_recipe 'mikoi::go'
end
