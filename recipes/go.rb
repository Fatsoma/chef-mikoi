#
# Cookbook Name:: mikoi
# Recipe:: default
#

include_recipe 'golang'

golang_package 'github.com/nabeken/mikoi'
