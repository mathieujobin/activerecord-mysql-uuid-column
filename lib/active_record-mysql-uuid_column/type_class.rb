module ActiveRecord
  module Type
    class Uuid < ActiveRecord::Type::Binary
      def type
        :uuid
      end

      # from database binary(16) to string
      def deserialize(value)
        return nil if value.nil?

        Data.from_database(value)
      end

      # from user input (string) to database
      def cast(value)
        if value.is_a?(Data)
          value
        elsif value.is_a?(ActiveSupport::ToJsonWithActiveSupportEncoder) || value.is_a?(String)
          Data.from_uuid_string(super)
        else
          raise ArgumentError, "Unsupported input data of class type #{value.class}"
        end
      end

      def serialize(value)
        value
      end

      def assert_valid_value(value)
        case value.class
        when String, ActiveSupport::ToJsonWithActiveSupportEncoder
          if value.blank? || value.to_s.downcase.gsub(/[^a-f0-9]/, '').size == 32
            value
          else
            raise SerializationTypeMismatch, "Invalid String uuid '#{value}'"
          end
        else
          raise SerializationTypeMismatch, "Unsupported value object of type #{value.class}."
        end
      end

      class Data
        def initialize(display_format, storage_format)
          @display_format = display_format
          @storage_format = storage_format
        end

        def self.from_uuid_string(uuid)
          return nil if uuid.nil?

          new(uuid, uuid.downcase.gsub(/[^a-f0-9]/, ''))
        end

        def self.from_database(value)
          return value if value.is_a? Data

          storage_format = value.unpack('H*').first.rjust(32, '0')
          new(
            storage_format.gsub(/^(.{8})(.{4})(.{4})(.{4})(.{12})$/, '\1-\2-\3-\4-\5'),
            storage_format
          )
        end

        def to_s
          @display_format
        end
        alias to_str to_s

        def hex
          @storage_format
        end

        def ==(other)
          other == to_s || super
        end
      end
    end
  end
end
