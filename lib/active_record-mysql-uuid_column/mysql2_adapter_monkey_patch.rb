# frozen_string_literal: true

require 'active_record/connection_adapters/mysql2_adapter'

module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter
      private

      def _quote(value)
        if value.is_a?(Type::Uuid::Data) || value.is_a?(Type::Binary::Data)
          "x'#{value.hex}'"
        else
          super
        end
      end
    end
  end
end
