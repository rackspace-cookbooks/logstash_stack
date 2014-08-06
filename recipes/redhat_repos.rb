#
# Cookbook Name:: logstash_stack
# Recipe:: redhat_package
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

include_recipe 'yum'

yum_repository 'logstash-1.4' do
  description 'logstash repository for 1.4.x packages'
  baseurl 'http://packages.elasticsearch.org/logstash/1.4/centos'
  gpgkey 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  action :create
end

yum_repository 'elasticsearch-1.3' do
  description 'Elasticsearch repository for 1.3.x packages'
  baseurl 'http://packages.elasticsearch.org/elasticsearch/1.3/centos'
  gpgkey 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  action :create
end

# epel for nginx
yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux 6 - $basearch'
  baseurl 'http://mirror.rackspace.com/epel/6/x86_64/'
  gpgkey 'http://mirror.rackspace.com/epel/RPM-GPG-KEY-EPEL-6'
  action :create
end
