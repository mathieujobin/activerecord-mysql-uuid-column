# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/mysql/uuid/column/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-mysql-uuid-column"
  spec.version       = Rails::Mysql::Uuid::Column::VERSION
  spec.authors       = ["Mathieu Jobin"]
  spec.email         = ["mathieu@justbudget.com"]

  spec.summary       = %q{This gem add support for a real uuid column for MySQL adapter.}
  spec.description   = %q{Most people use varchar(36) for storing uuids, which is very wrong for storing a 128 bit integer.}
  spec.homepage      = "https://github.com/mathieujobin/rails-mysql-uuid-column"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
