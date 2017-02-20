require "active_record-mysql-uuid_column/version"
require 'active_record'

module ActiveModel
  module Type
    class Uuid
      def method_missing(name)
        debugger
        puts "whatever"
      end
    end
  end
end
module ActiveRecord
  module ConnectionAdapters
    module MySQL
      module ColumnMethods
        def uuid(*args, **options)
          # http://dba.stackexchange.com/questions/904/mysql-data-type-for-128-bit-integers
          # http://dev.mysql.com/doc/refman/5.7/en/binary-varbinary.html
          args.each { |name| column(name, :binary, options.merge(limit: 16)) }
        end
      end
    end

  end
end

