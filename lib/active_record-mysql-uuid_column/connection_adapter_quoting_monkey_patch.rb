require 'active_record/connection_adapters/abstract/quoting'

module ActiveRecordConnectionAdaptersUuidQuoting
  def quote(value)
    if value.is_a?(ActiveRecord::Type::Uuid::Data) # || value.is_a?(Type::Binary::Data)
      # "x'#{value.hex}'"
      quoted_binary(value)
    else
      super
    end
  end
end

ActiveRecord::ConnectionAdapters::Quoting.prepend ActiveRecordConnectionAdaptersUuidQuoting
