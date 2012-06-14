#
# Cookbook Name:: nginx_inmobi
# Recipe:: default
#
# Copyright 2012, InMobi
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin


case node[:platform]
when "ubuntu", "debian"
  node[:nginx_inmobi][:packages] = [
    "mkhoj-base",
    "ngin-johndoe"
  ]

nginx_inmobi "install packages" do
  persist true
  packages node[:nginx_inmobi][:packages] do
  action :install
end

template "#{node[:nginx_inmobi][:dir]}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
end


nginx_inmobi "setup config" do
  persist true
  action :setup_config
end

rightscale_marker :end
