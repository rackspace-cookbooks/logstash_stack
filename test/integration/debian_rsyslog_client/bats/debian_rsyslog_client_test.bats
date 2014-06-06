@test "rsyslog is installed, enabled, and running" {
	if [ $(lsb_release -si) == "Ubuntu" ]
	then
		[[ -f /etc/init/rsyslog.conf ]]
		initctl show-config rsyslog | grep "start on"
	elif [ $(lsb_release -si) == "Debian" ]
	then
		/etc/init.d/rsyslog status
		test -f /etc/rc3.d/S??rsyslog
	fi
}

@test "logstash rsyslog config file was created from template resource" {
	[[ -f /etc/rsyslog.d/logstash_rsyslog_client.conf ]]
}
