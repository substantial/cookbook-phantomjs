#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2012, Substantial Inc.
#
# All rights reserved - Do Not Redistribute

bash 'Get phantomjs source' do
  cwd '/usr/local/src'
  code %{
    git clone #{node[:phantomjs][:repository]}
    cd phantomjs
    git checkout #{node[:phantomjs][:version]}
  }
  not_if '[ -d /usr/local/src/phantomjs ]'
end

bash 'Update phantomjs' do
  cwd '/usr/local/src/phantomjs'
  code %{
    git pull origin
    git checkout #{node[:phantomjs][:version]}
    git clean -xfd .
  }
  only_if "[ $(phantomjs --version | grep -c '#{node[:phantomjs][:version]}') -lt 1 ]"
end

bash 'Build phantomjs binary' do
  cwd '/usr/local/src/phantomjs'
  code %{
    ./build.sh --jobs 1
    deploy/package-linux-dynamic.sh
    tar -zxf phantomjs.tar.gz -C /usr/local/
    rm /usr/local/bin/phantomjs
    ln -s /usr/local/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
  }
  only_if "[ $(phantomjs --version | grep -c '#{node[:phantomjs][:version]}') -lt 1 ]"
end
