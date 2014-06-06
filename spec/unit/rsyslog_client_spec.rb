require 'spec_helper'

describe 'logstash_stack::rsyslog_client' do
  context 'on ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') }

    # Need a way to bypass the stub requirement so we could see what would
    # actually happen if it ran in chef solo on a server
    it 'fails in chef solo mode with no server_ip attribute set' do
      # expect { chef_run.converge(described_recipe) }.to raise_error(ChefSpec::Error::SearchNotStubbed)
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'fails when logstash server search returns empty' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([])
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'adds rsyslog conf file with searched IP' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([{ ipaddress: '10.120.130.140' }])
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.120.130.140:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end

    it 'adds rsyslog conf file when logstash_server_ip is set' do
      chef_run.node.set['logstash_stack']['logstash_server_ip'] = '10.20.30.40'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.20.30.40:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end
  end

  context 'on debian' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.2') }

    # Need a way to bypass the stub requirement so we could see what would
    # actually happen if it ran in chef solo on a server
    it 'fails in chef solo mode with no server_ip attribute set' do
      # expect { chef_run.converge(described_recipe) }.to raise_error(ChefSpec::Error::SearchNotStubbed)
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'fails when logstash server search returns empty' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([])
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'adds rsyslog conf file with searched IP' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([{ ipaddress: '10.120.130.140' }])
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.120.130.140:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end

    it 'adds rsyslog conf file when logstash_server_ip is set' do
      chef_run.node.set['logstash_stack']['logstash_server_ip'] = '10.20.30.40'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.20.30.40:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end
  end

  context 'on centos' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4') }

    # Need a way to bypass the stub requirement so we could see what would
    # actually happen if it ran in chef solo on a server
    it 'fails in chef solo mode with no server_ip attribute set' do
      # expect { chef_run.converge(described_recipe) }.to raise_error(ChefSpec::Error::SearchNotStubbed)
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'fails when logstash server search returns empty' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([])
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end

    it 'adds rsyslog conf file with searched IP' do
      stub_search(:node, 'recipes:logstash_stack\:\:logstash' << " AND chef_environment:#{chef_run.node.chef_environment}").and_return([{ ipaddress: '10.120.130.140' }])
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.120.130.140:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end

    it 'adds rsyslog conf when logstash_server_ip is set' do
      chef_run.node.set['logstash_stack']['logstash_server_ip'] = '10.20.30.40'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rsyslog')
      expect(chef_run).to create_template('/etc/rsyslog.d/logstash_rsyslog_client.conf')
      expect(chef_run).to render_file('/etc/rsyslog.d/logstash_rsyslog_client.conf').with_content('10.20.30.40:5544')
      expect(chef_run.template('/etc/rsyslog.d/logstash_rsyslog_client.conf')).to notify('service[rsyslog]').to(:restart)
      expect(chef_run).to enable_service('rsyslog')
      expect(chef_run).to start_service('rsyslog')
    end
  end
end
