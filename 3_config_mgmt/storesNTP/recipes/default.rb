#
# Cookbook Name:: storesNTP
# Recipe:: default
## Author:: Joshua Timberman (<joshua@opscode.com>)
#  Derivative Work Author:: Michael Jones (<michael.jones@thoughtworks.com>)
#
##

node[:storesNTP][:packages].each do |ntppkg|
  package ntppkg
end

[ node[:storesNTP][:varlibdir],
  node[:storesNTP][:statsdir] ].each do |ntpdir|
  directory ntpdir do
    owner node[:storesNTP][:var_owner]
    group node[:storesNTP][:var_group]
    mode 0755
  end
end

service node[:storesNTP][:service] do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

cookbook_file node[:storesNTP][:leapfile] do
  owner node[:storesNTP][:conf_owner]
  group node[:storesNTP][:conf_group]
  mode 0644
end

template '/etc/ntp.conf' do
  source 'ntp.conf.erb'
  owner node[:storesNTP][:conf_owner] 
  group node[:storesNTP][:conf_group]
  mode 0644
  notifies :restart, resources(:service => node[:storesNTP][:service])
end
