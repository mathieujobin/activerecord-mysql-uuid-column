require "spec_helper"
require 'active_record'

describe Rails::Mysql::Uuid::Column do
  it "has a version number" do
    expect(Rails::Mysql::Uuid::Column::VERSION).not_to be nil
  end

  it "allow migrations to have uuid column" do

    env = ENV['RAILS_ENV'] || 'test'
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')

    # create the current database (test), like rake db:create
    ActiveRecord::Tasks::DatabaseTasks.create_current(env)

    # like rake db:schema:load
    load 'support/db_schema.rb'

    class TestTable < ActiveRecord::Base; end

    expect(TestTable.uuid).to eq(true)
  end
end
