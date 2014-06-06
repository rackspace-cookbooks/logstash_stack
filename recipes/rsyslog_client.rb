#
# Cookbook Name:: logstash_stack
# Recipe:: rsyslog_client
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

require 'chef/application'

package 'rsyslog'

if node['logstash_stack']['logstash_server_ip'].nil?
  begin
    result = search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{node.chef_environment}").first # ~FC003
  rescue Chef::Exceptions::PrivateKeyMissing, ChefSpec::Error::SearchNotStubbed
    Chef::Application.fatal!("In chef-solo mode, you must set the node['logstash_stack']['logstash_server_ip'] attribute.")
  end
  if result.nil?
    Chef::Application.fatal!('Search did not find a logstash server. '\
                             "Set the node['logstash_stack']['logstash_server_ip'] attribute. "\
                             'This is required if running in chef-solo')
  else
    node.set['logstash_stack']['logstash_server_ip'] = result['ipaddress']
  end
end

template '/etc/rsyslog.d/logstash_rsyslog_client.conf' do
  source    'logstash_rsyslog_client.conf.erb'
  owner     'root'
  group     'root'
  mode      '0644'
  notifies  :restart, 'service[rsyslog]'
  variables(cookbook_name: cookbook_name)
end

service 'rsyslog' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
