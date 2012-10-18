#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2012, Substantial Inc.
#
# All rights reserved - Do Not Redistribute

if node.kernel.machine == "x86_84"
  tar_url = node[:phantomjs][:x86_64][:tar_url]
  tar_checksum = node[:phantomjs][:x86_64][:checksum]
  filename = node[:phantomjs][:x86_64][:filename]
else
  tar_url = node[:phantomjs][:x86][:tar_url]
  tar_checksum = node[:phantomjs][:x86][:checksum]
  filename = node[:phantomjs][:x86][:filename]
end

remote_file "Downloading phantomjs tar" do
  path "/tmp/#{filename}"
  source tar_url
  mode "0644"
  checksum tar_checksum
  action :create_if_missing
end

bash 'untar phantomjs' do
  code %{
    tar -zxf /tmp/#{filename} -C /usr/local/
  }
end

link "/usr/bin/phantomjs" do
  to "/usr/local/phantomjs/bin/phantomjs"
end
