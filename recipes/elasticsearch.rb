#
# Cookbook Name:: logstash_stack
# Recipe:: elasticsearch
#
# Copyright (C) 2014, Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  package 'java-1.7.0-openjdk'
when 'debian'
  package 'openjdk-7-jre-headless'
end

package 'elasticsearch'

# Template just sets a cluster name, everything else is default.
template '/etc/elasticsearch/elasticsearch.yml' do
  source    'elasticsearch.yml.erb'
  owner     'root'
  group     'root'
  mode      '0644'
  notifies  :restart, 'service[elasticsearch]'
  variables(cookbook_name: cookbook_name)
end

service 'elasticsearch' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
