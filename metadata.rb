name              'logstash_stack'
maintainer        'Rackspace, US, Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs/Configures logstash_stack'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.2.0'

recipe            'logstash_stack', 'Installs a complete logstash stack'
recipe            'logstash_stack::rsyslog_client', 'Configures rsyslog to ship logs to logstash server'

%w(redhat centos debian ubuntu).each do |os|
  supports os
end

depends 'yum', '~> 3.2'
depends 'apt', '~> 2.4'
depends 'openssl'
