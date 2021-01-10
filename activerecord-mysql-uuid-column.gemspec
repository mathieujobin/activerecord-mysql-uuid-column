# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record-mysql-uuid_column/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-mysql-uuid-column"
  spec.version       = ActiveRecord::Mysql::UuidColumn::VERSION
  spec.authors       = ["Mathieu Jobin"]
  spec.email         = ["mathieu@justbudget.com"]

  spec.summary       = 'Adds a :uuid column to ActiveRecord MySQL2 Adapter. Store UUIDs as 16 bytes binary column.'
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mathieujobin/activerecord-mysql-uuid-column"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.5"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "codecov"
  spec.add_development_dependency "looksee" if RUBY_VERSION < '3.0'
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_dependency "activerecord", ">= 5", "< 7"
  spec.add_dependency "mysql2"
end
