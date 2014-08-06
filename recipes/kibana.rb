#
# Cookbook Name:: logstash_stack
# Recipe:: kibana
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

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

package 'nginx'

case node['platform_family']
when 'debian'
  package 'apache2-utils'
when 'rhel'
  package 'httpd-tools'
end

node.set_unless['logstash_stack']['kibana']['htpasswd'] = secure_password

execute 'create kibana htpasswd file' do
  command "htpasswd -bc /etc/nginx/logstash.htpasswd kibana #{node['logstash_stack']['kibana']['htpasswd']}"
  only_if { File.size?('/etc/nginx/logstash.htpasswd').nil? }
end

template '/etc/nginx/conf.d/default.conf' do
  source    'nginx_default.conf.erb'
  owner     'root'
  group     'root'
  mode      '0644'
  notifies  :restart, 'service[nginx]'
  variables(cookbook_name: cookbook_name)
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
