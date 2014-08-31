#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum-epel"

package "nginx" do
  action :install
end

service "nginx" do
  action [ :enable, :start]
  supports :status => true, :restart => true, :reload => true
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source "nginx.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end

directory '/home/vagrant/html' do
  owner 'vagrant'
  group 'root'
  mode '0777'
  action :create
end

link '/usr/share/nginx/html/scr' do
  to '/home/vagrant/html'
  link_type  :symbolic
end
