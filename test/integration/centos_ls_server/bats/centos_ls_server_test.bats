@test "ElasticSearch is enabled and running" {
	chkconfig --list elasticsearch | grep 3:on
	service elasticsearch status
}

@test "Logstash is enabled and running" {
	chkconfig --list logstash | grep 3:on
	service logstash status
}

@test "NginX is enabled, running, listening on 80, and serving Kibana" {
	chkconfig --list nginx | grep 3:on
	service nginx status
	netstat -lntp | grep nginx | grep ":80 "
	grep kibana /etc/nginx/conf.d/default.conf
}

@test "Connect to confirm end-to-end deployment" {
	wget --user kibana --password kibana -q http://127.0.0.1 -O - | grep Kibana
}
