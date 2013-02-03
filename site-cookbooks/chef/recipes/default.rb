#
# Cookbook Name:: chef
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
gem_package "chef" do
  gem_binary node['user']['home'] + "/.rbenv/shims/gem"
  action :install
end
