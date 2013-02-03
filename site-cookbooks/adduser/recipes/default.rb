#
# Cookbook Name:: adduser
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user node['user']['name'] do
  comment node['user']['name']
  home node['user']['home']
  password nil
  supports :manage_home => true
end

template "sudoers" do
  path "/etc/sudoers.d/" + node['user']['name']
  source "sudoers.erb"
  owner "root"
  group "root"
  mode 0440
end
