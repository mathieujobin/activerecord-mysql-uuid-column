# frozen_string_literal: true

require 'active_record'
require 'active_record-mysql-uuid_column/version'
require 'active_record-mysql-uuid_column/migration_column'
require 'active_record-mysql-uuid_column/type_class'

if ActiveRecord.version.to_s >= '7.0'
  require 'active_record-mysql-uuid_column/connection_adapter_quoting_monkey_patch'
else
  require 'active_record-mysql-uuid_column/mysql2_adapter_monkey_patch'
end

ActiveRecord::Type.register(:uuid, ActiveRecord::Type::Uuid, adapter: :mysql2)
