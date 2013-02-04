#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{git gcc make readline-devel openssl-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/tmp/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  # action :sync
  action :checkout
end

bash "install-rubybuild" do
  not_if 'which ruby-build'
  code <<-EOC
    cd /tmp/ruby-build
    ./install.sh
  EOC
end

git node['user']['home'] + "/.rbenv" do
  user node['user']['name']
  group node['user']['group']
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  # action :sync
  action :checkout
end

bash "rbenv" do
  user node['user']['name']
  group node['user']['group'] 
  cwd node['user']['home']
  environment "HOME" => node['user']['home']

  code <<-EOC
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    rbenv install #{node['rbenv']['version']}
    rbenv global #{node['rbenv']['version']}
    rbenv versions
    rbenv rehash
  EOC

  not_if { File.exists?(node['user']['home'] + "/.rbenv/shims/ruby") }
end
