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

  it "accept uuid as string for input and returns back uuid as a string on read" do
    uuid = SecureRandom.uuid
    test_subject = TestUuid.create!(uuid: uuid)
    test_subject.reload
    expect(test_subject.uuid).to eq(uuid)
  end

  ######
  ## With 1000 rows, before adding shuffle, it is slightly faster with this implementation
  ## but is it worth it? it's unclear. since using a string is so simple.
  ## the space saving must be worth it, otherwise, its probably best not to bother
  # Took 14476.508187130094 to create
  # Took 6511.794489109889 to find by string
  # Took 5781.501437071711 to find by text
  # Took 5614.035954931751 to find by uuid
  ## Interesting to see text almost just as fast as uuid binary

  ## With 5000 rows and adding shuffle
  # Took 70345.54825420491 to create
  # Took 27699.95204010047 to find by string
  # Took 30197.602536994964 to find by text
  # Took 27523.164969868958 to find by uuid
  ## uuid is only slightly faster than string. text is now slower.

  ## With 500 rows and keeping shuffle
  # Took 6333.7121868971735 to create
  # Took 2035.671924939379 to find by string
  # Took 1415.6075660139322 to find by text
  # Took 1991.2620580289513 to find by uuid

  it "should be faster than storing UUID as strings" do
    uuid_collection = 500.times.map { SecureRandom.uuid }
    creation_time = Benchmark.ms do
      uuid_collection.each do |uuid|
        TestUuid.create!(uuid: uuid, name: uuid, description: uuid)
      end
    end
    puts "Took #{creation_time} to create"

    search_all_uuids_by_string_time = Benchmark.ms do
      uuid_collection.shuffle.each do |uuid|
        object = TestUuid.where(name: uuid).first
        expect([object.uuid.to_s, object.name, object.description, uuid].uniq).to eq [uuid]
      end
    end
    puts "Took #{search_all_uuids_by_string_time} to find by string"

    search_all_uuids_by_text_time = Benchmark.ms do
      uuid_collection.shuffle.each do |uuid|
        object = TestUuid.where(description: uuid).first
        expect([object.uuid.to_s, object.name, object.description, uuid].uniq).to eq [uuid]
      end
    end
    puts "Took #{search_all_uuids_by_text_time} to find by text"

    search_all_uuids_by_uuid_time = Benchmark.ms do
      uuid_collection.shuffle.each do |uuid|
        object = TestUuid.where(uuid: ActiveRecord::Type::Uuid::Data.from_uuid_string(uuid)).first
        expect([object.uuid.to_s, object.name, object.description, uuid].uniq).to eq [uuid]
      end
    end
    puts "Took #{search_all_uuids_by_uuid_time} to find by uuid"
  end
end
