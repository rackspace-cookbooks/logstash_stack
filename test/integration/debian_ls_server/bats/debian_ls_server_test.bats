@test "ElasticSearch is enabled and running" {
	test -f /etc/rc3.d/S??elasticsearch
	/etc/init.d/elasticsearch status
}

@test "Logstash is enabled and running" {
	test -f /etc/rc3.d/S??logstash
	/etc/init.d/logstash status
}

@test "NginX is enabled, running, listening on 80, and serving Kibana" {
	test -f /etc/rc3.d/S??nginx
	/etc/init.d/nginx status
	netstat -lntp | grep nginx | grep ":80 "
	grep kibana /etc/nginx/conf.d/default.conf
}

@test "Connect to confirm end-to-end deployment" {
	wget -q http://127.0.0.1 -O - | grep Kibana
}
