#
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
# Derivative Work Author:: Michael Jones (<michael.jones@thoughtworks.com>)
#
# Cookbook Name:: storesNTP
# Recipe:: disable
#

service node[:storesNTP][:service] do
	action [ :disable, :stop ]
end

case node[:platform]
when 'ubuntu','debian'
	template '/etc/default/ntpdate' do
		source 'ntpdate.erb'
		owner root
		group root_group
		mode 0644
		variables :disable => TRUE
	end
end
