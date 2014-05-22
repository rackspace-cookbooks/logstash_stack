source 'https://rubygems.org'

gem 'berkshelf', '~> 3.0'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.5.2"
# end
#
# group :plugins do
#   gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
#   gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
# end

group :testing do
  gem 'chefspec',           '~> 3.4'
  gem 'foodcritic',         '~> 3.0'
  gem 'thor',               '~> 0.19'
  gem 'chef',               '~> 11.12'
  gem 'rspec',              '~> 2.14'
  gem 'rubocop',            '~> 0.21'
  gem 'rake',               '~> 10.3'
end

group :integration do
  gem 'test-kitchen',       '~> 1.2'
  gem 'kitchen-vagrant',    '~> 0.15'
  gem 'kitchen-rackspace',  '~> 0.6'
  gem 'serverspec',         '~> 1.6'
  gem 'vagrant-wrapper',    '~> 1.2'
end
