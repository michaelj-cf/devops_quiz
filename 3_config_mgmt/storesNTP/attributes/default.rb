#
# Cookbook Name:: storesNTP
# Attributes:: default
#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Derivative Work Author:: Michael Jones (<michael.jones@thoughtworks.com>)
# Copyright Opscode, Inc.
#

# default attributes for all platforms
default[:storesNTP][:servers]   = %w{ 0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org }
default[:storesNTP][:peers] = Array.new
default[:storesNTP][:restrictions] = Array.new

default[:storesNTP][:packages] = %w{ ntp ntpdate }
default[:storesNTP][:service] = 'ntp'
default[:storesNTP][:varlibdir] = '/var/lib/ntp'
default[:storesNTP][:driftfile] = "#{node[:storesNTP][:varlibdir]}/ntp.drift"
default[:storesNTP][:statsdir] = '/var/log/ntpstats/'
default[:storesNTP][:conf_owner] = 'root'
default[:storesNTP][:conf_group] = 'root'
default[:storesNTP][:var_owner] = 'ntp'
default[:storesNTP][:var_group] = 'ntp'
default[:storesNTP][:leapfile] = '/etc/ntp.leapseconds'

# overrides on a platform-by-platform basis
case platform_family
when 'rhel'
  default[:storesNTP][:service] = 'ntpd'
  default[:storesNTP][:packages] = %w{ ntp }
  if node[:platform_version].to_i >= 6
    default[:storesNTP][:packages] = %w{ ntp ntpdate } 
  end
when 'suse'
  default[:storesNTP][:packages] = %w{ ntp }
when 'freebsd'
  default[:storesNTP][:service] = 'ntpd'
  default[:storesNTP][:varlibdir] = '/var/db'
  default[:storesNTP][:driftfile] = "#{node[:storesNTP][:varlibdir]}/ntpd.drift"
  default[:storesNTP][:statsdir] = "#{node[:storesNTP][:varlibdir]}/ntpstats"
  default[:storesNTP][:packages] = %w{ ntp }
  default[:storesNTP][:conf_group] = 'wheel'
  default[:storesNTP][:var_group] = 'wheel' 
end
