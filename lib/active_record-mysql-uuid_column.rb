# frozen_string_literal: true

require 'active_record'
require 'active_record/connection_adapters/mysql2_adapter'
require 'active_record-mysql-uuid_column/version'
require 'active_record-mysql-uuid_column/migration_column'
require 'active_record-mysql-uuid_column/type_class'
require 'active_record-mysql-uuid_column/mysql2_adapter_monkey_patch'

ActiveRecord::Type.register(:uuid, ActiveRecord::Type::Uuid, adapter: :mysql2)
