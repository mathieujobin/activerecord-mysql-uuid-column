# ActiveRecord::Mysql::UuidColumn

Adds a :uuid column to ActiveRecord MySQL2 Adapter
it is stored in a 16 bytes binary column. which is exactly the space it needs.

[![Gem Version](https://badge.fury.io/rb/activerecord-mysql-uuid-column.svg)](https://badge.fury.io/rb/activerecord-mysql-uuid-column)
[![Build Status](https://travis-ci.org/mathieujobin/activerecord-mysql-uuid-column.svg?branch=master)](https://travis-ci.org/mathieujobin/activerecord-mysql-uuid-column)
![GitHub release](https://img.shields.io/github/release/mathieujobin/activerecord-mysql-uuid-column.svg)
[![Codecov](https://img.shields.io/codecov/c/github/mathieujobin/activerecord-mysql-uuid-column.svg)](https://codecov.io/gh/mathieujobin/activerecord-mysql-uuid-column)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-mysql-uuid-column'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-mysql-uuid-column

## Usage

Regular MySQL ActiveRecord config
```
test:
  adapter: mysql2
  username: root
  host: localhost
  reconnect: true
  database: awesome_project_of_yours
```

Adds column type `uuid`

```
ActiveRecord::Schema.define(version: 20161122225732) do
  create_table "workers", force: true do |t|
    t.uuid     "job_uuid"
  end
end
```

Define it in your model

```
class Worker < ActiveRecord::Base
  attribute :job_uuid, :uuid
end
```

Then use as regular string column, except that it will be stored in a 16 bytes binary column.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mathieujobin/activerecord-mysql-uuid-column. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Online API Doc
* http://www.rubydoc.info/gems/activerecord-mysql-uuid-column/0.1.0

## On libraries.io
* https://libraries.io/rubygems/activerecord-mysql-uuid-column

## Resources
* https://christoph.luppri.ch/articles/2017/01/07/adding-custom-types-to-your-activerecord-models-with-the-attributes-api/
* https://karolgalanciak.com/blog/2016/12/04/introduction-to-activerecord-and-activemodel-attributes-api/
* https://blog.metova.com/rails-5-attributes-api
* https://gorails.com/episodes/virtual-attributes-and-rails-5-attribute-api

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

