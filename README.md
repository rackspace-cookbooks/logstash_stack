# logstash_stack-cookbook

A free standing Logstash 1.4, Elasticsearch 1.1, Kibana 3.0 rapid deployment cookbook.  This is designed to get up and running quickly and easily with packages from repos, and mostly default options.  Supports adding additional ES shards.

The logstash server will setup a syslog listener on 5544.  Feel free to direct your syslogs at it.  If you want additional plugins, or agent, you're more than welcome to write a wrapper cookbook to include that.  This cookbook should remain mostly static.

## Supported Platforms

RHEL, Debian

## Attributes

## Usage

### logstash_stack::default

Include `logstash_stack` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[logstash_stack::default]"
  ]
}
```

### logstash_stack:elasticsearch

If you want ElasticSearch redundancy/sharding for logstash, you can run only the elasticsearch recipe:

```json
{
  "run_list": [
    "recipe[logstash_stack::elasticsearch]"
  ]
}
```

## Contributing

Please see contributing guidelines at [contributing](https://github.com/rackspac
e-cookbooks/contributing/blob/master/CONTRIBUTING.md)

## License and Authors

Author:: Jason Nelson (<jason.nelson@rackspace.com>)

```text
Copyright:: 2014, Rackspace, US Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```