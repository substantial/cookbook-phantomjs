#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2012, Substantial Inc.
#
# All rights reserved - Do Not Redistribute

tar_url = node[:phantomjs][:x86_64][:tar_url]
tar_checksum = node[:phantomjs][:x86_64][:checksum]
filename = node[:phantomjs][:x86_64][:filename]

file_path = "#{Chef::Config[:file_cache_path]}/#{filename}"
remote_file "Downloading phantomjs tar" do
  path file_path
  source tar_url
  mode "0644"
  checksum tar_checksum
  action :create_if_missing
end

unzip_flag = 'z'
unzip_flag = 'j' if filename =~ /\.bz2$/

# strip off both extentions
default_install_path = File.basename(filename, File.extname(filename))
default_install_path = File.basename(default_install_path, File.extname(default_install_path))

install_path = node[:phantomjs][:extracted_folder_name] || default_install_path

bash 'untar phantomjs' do
  code %{
    tar -#{unzip_flag}xf #{file_path} -C /usr/local/
  }
  not_if { File.exists? "/usr/local/#{install_path}" }
end

link "/usr/bin/phantomjs" do
  to "/usr/local/#{install_path}/bin/phantomjs"
end
