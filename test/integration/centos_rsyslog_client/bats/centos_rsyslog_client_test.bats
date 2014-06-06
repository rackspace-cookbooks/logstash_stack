@test "rsyslog is installed, enabled, and running" {
	chkconfig --list rsyslog | grep 3:on
	service rsyslog status
}

@test "logstash rsyslog config file was created from template resource" {
	[[ -f /etc/rsyslog.d/logstash_rsyslog_client.conf ]]
}
