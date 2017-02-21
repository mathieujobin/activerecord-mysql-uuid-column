# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record-mysql-uuid_column/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-mysql-uuid-column"
  spec.version       = ActiveRecord::Mysql::UuidColumn::VERSION
  spec.authors       = ["Mathieu Jobin"]
  spec.email         = ["mathieu@justbudget.com"]

  spec.summary       = %q{This gem add support for a real uuid column for MySQL adapter.}
  spec.description   = %q{Most people use varchar(36) for storing uuids, which is very wrong for storing a 128 bit integer.}
  spec.homepage      = "https://github.com/mathieujobin/activerecord-mysql-uuid-column"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", '~> 0'
  spec.add_development_dependency "looksee", '~> 0'
  spec.add_dependency "activerecord", ">= 4.2.5", "< 6"
  spec.add_dependency "mysql2", "~> 0.4.0"
end
