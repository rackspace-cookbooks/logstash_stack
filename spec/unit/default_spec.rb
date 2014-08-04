require 'spec_helper'

describe 'logstash_stack::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it 'sets up repos for Ubuntu' do
    expect(chef_run).to include_recipe('apt')
    expect(chef_run).to add_apt_repository('logstash-1.4')
    expect(chef_run).to add_apt_repository('elasticsearch-1.1')
  end

  it 'installs java and elasticsearch' do
    expect(chef_run).to install_package('openjdk-7-jre-headless')
    expect(chef_run).to install_package('elasticsearch')
    expect(chef_run).to create_template('/etc/elasticsearch/elasticsearch.yml')
    expect(chef_run).to render_file('/etc/elasticsearch/elasticsearch.yml').with_content('logstash')
    expect(chef_run.template('/etc/elasticsearch/elasticsearch.yml')).to notify('service[elasticsearch]').to(:restart)
    expect(chef_run).to enable_service('elasticsearch')
    expect(chef_run).to start_service('elasticsearch')
  end

  it 'installs logstash' do
    expect(chef_run).to install_package('logstash')
    expect(chef_run).to create_template('/etc/logstash/conf.d/logstash_syslog.conf')
    expect(chef_run).to render_file('/etc/logstash/conf.d/logstash_syslog.conf').with_content('elasticsearch')
    expect(chef_run.template('/etc/logstash/conf.d/logstash_syslog.conf')).to notify('service[logstash]').to(:restart)
    expect(chef_run).to enable_service('logstash')
    expect(chef_run).to start_service('logstash')
  end

  it 'installs nginx and sets up kibana' do
    expect(chef_run).to install_package('nginx')
    expect(chef_run).to install_package('httpd-tools')
    expect(chef_run).to run_execute('create kibana htpasswd file')
    expect(chef_run).to create_template('/etc/nginx/conf.d/default.conf')
    expect(chef_run).to render_file('/etc/nginx/conf.d/default.conf').with_content('kibana')
    expect(chef_run.template('/etc/nginx/conf.d/default.conf')).to notify('service[nginx]').to(:restart)
    expect(chef_run).to enable_service('nginx')
    expect(chef_run).to start_service('nginx')
  end
end

describe 'logstash_stack::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.2').converge(described_recipe) }

  it 'sets up repos for Debian' do
    expect(chef_run).to include_recipe('apt')
    expect(chef_run).to add_apt_repository('logstash-1.4')
    expect(chef_run).to add_apt_repository('elasticsearch-1.1')
  end

  it 'installs java and elasticsearch' do
    expect(chef_run).to install_package('openjdk-7-jre-headless')
    expect(chef_run).to install_package('elasticsearch')
    expect(chef_run).to create_template('/etc/elasticsearch/elasticsearch.yml')
    expect(chef_run).to render_file('/etc/elasticsearch/elasticsearch.yml').with_content('logstash')
    expect(chef_run.template('/etc/elasticsearch/elasticsearch.yml')).to notify('service[elasticsearch]').to(:restart)
    expect(chef_run).to enable_service('elasticsearch')
    expect(chef_run).to start_service('elasticsearch')
  end

  it 'installs logstash' do
    expect(chef_run).to install_package('logstash')
    expect(chef_run).to create_template('/etc/logstash/conf.d/logstash_syslog.conf')
    expect(chef_run).to render_file('/etc/logstash/conf.d/logstash_syslog.conf').with_content('elasticsearch')
    expect(chef_run.template('/etc/logstash/conf.d/logstash_syslog.conf')).to notify('service[logstash]').to(:restart)
    expect(chef_run).to enable_service('logstash')
    expect(chef_run).to start_service('logstash')
  end

  it 'installs nginx and sets up kibana' do
    expect(chef_run).to install_package('nginx')
    expect(chef_run).to create_template('/etc/nginx/conf.d/default.conf')
    expect(chef_run).to render_file('/etc/nginx/conf.d/default.conf').with_content('kibana')
    expect(chef_run.template('/etc/nginx/conf.d/default.conf')).to notify('service[nginx]').to(:restart)
    expect(chef_run).to enable_service('nginx')
    expect(chef_run).to start_service('nginx')
  end
end

describe 'logstash_stack::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'sets up repos for CentOS' do
    expect(chef_run).to include_recipe('yum')
    expect(chef_run).to create_yum_repository('logstash-1.4')
    expect(chef_run).to create_yum_repository('elasticsearch-1.1')
    expect(chef_run).to create_yum_repository('epel')
  end

  it 'installs java and elasticsearch' do
    expect(chef_run).to install_package('java-1.7.0-openjdk')
    expect(chef_run).to install_package('elasticsearch')
    expect(chef_run).to create_template('/etc/elasticsearch/elasticsearch.yml')
    expect(chef_run).to render_file('/etc/elasticsearch/elasticsearch.yml').with_content('logstash')
    expect(chef_run.template('/etc/elasticsearch/elasticsearch.yml')).to notify('service[elasticsearch]').to(:restart)
    expect(chef_run).to enable_service('elasticsearch')
    expect(chef_run).to start_service('elasticsearch')
  end

  it 'installs logstash' do
    expect(chef_run).to install_package('logstash')
    expect(chef_run).to create_template('/etc/logstash/conf.d/logstash_syslog.conf')
    expect(chef_run).to render_file('/etc/logstash/conf.d/logstash_syslog.conf').with_content('elasticsearch')
    expect(chef_run.template('/etc/logstash/conf.d/logstash_syslog.conf')).to notify('service[logstash]').to(:restart)
    expect(chef_run).to enable_service('logstash')
    expect(chef_run).to start_service('logstash')
  end

  it 'installs nginx and sets up kibana' do
    expect(chef_run).to install_package('nginx')
    expect(chef_run).to create_template('/etc/nginx/conf.d/default.conf')
    expect(chef_run).to render_file('/etc/nginx/conf.d/default.conf').with_content('kibana')
    expect(chef_run.template('/etc/nginx/conf.d/default.conf')).to notify('service[nginx]').to(:restart)
    expect(chef_run).to enable_service('nginx')
    expect(chef_run).to start_service('nginx')
  end

end
