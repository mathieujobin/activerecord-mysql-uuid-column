require "spec_helper"

class TestUuid < ActiveRecord::Base
  attribute :uuid, :uuid
end

describe ActiveRecord::Mysql::UuidColumn do
  it "has a version number" do
    expect(ActiveRecord::Mysql::UuidColumn::VERSION).not_to be nil
  end

  before do
    env = ENV['RAILS_ENV'] || 'test'

    ActiveRecord::Base.configurations = YAML.load_file('spec/support/config_database.yml')

    # create the current database (test), like rake db:create
    ActiveRecord::Tasks::DatabaseTasks.create_current(env)

    # like rake db:schema:load
    load 'spec/support/db_schema.rb'
  end

  it "allow migrations to have uuid column" do
    expect(TestUuid.columns_hash['uuid'].sql_type).to eq("varbinary(16)")
    expect(TestUuid.columns_hash['uuid'].limit).to eq(16)
    expect(TestUuid.columns_hash['uuid'].type).to eq(:binary)
  end

  it "call nc" do
    `nc -z localhost 8282`
    case $?.exitstatus
    when 0
      #port is open
      true
    when 1
      assert_equal 1, 0 # nc is installed but port was closed
    else
      # likely 127, nc is not available, ignoring failure
    end
  end

  it "accept uuid as string for input and returns back uuid as a string on read" do
    uuid = SecureRandom.uuid
    test_subject = TestUuid.create!(uuid: uuid)
    test_subject.reload
    expect(test_subject.uuid).to eq(uuid)
  end
end
