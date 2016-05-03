#
# Cookbook Name:: storesNT
# Recipe:: undo 
# Author:: Eric G. Wolfe 
# Derivative Work Author:: Michael Jones (<michael.jones@thoughtworks.com>)
#
service node[:storesNTP][:service] do
  supports :status => true, :restart => true
  action [ :stop, :disable ]
end

node[:storesNTP][:packages].each do |ntppkg|
  package ntppkg do
    action :remove
  end
end

ruby_block "remove storesNTP::undo from run list" do
  block do
    node.run_list.remove('recipe[storesNTP::undo]')
  end
end
