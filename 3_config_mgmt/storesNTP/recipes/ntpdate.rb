#
# Cookbook Name:: storesNTP
# Recipe:: ntpdate 
# Author:: Eric G. Wolfe 
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Derivative Work Author:: Michael Jones (<michael.jones@thoughtworks.com>)
#

# Package declaration a bit redundant,
# but not if this runs as a standalone recipe
package 'ntpdate' do
  only_if { node[:platform] == 'debian' or node[:platform] == 'ubuntu' }
end

# Template is only meaningful on Debian family platforms
template '/etc/default/ntpdate' do
  owner node[:storesNTP][:conf_owner]
  group node[:storesNTP][:conf_group]
  mode 0644
  variables :disable => node[:storesNTP][:storesNTPdate][:disable]
  only_if { node[:platform] == 'debian' or node[:platform] == 'ubuntu' }
end
