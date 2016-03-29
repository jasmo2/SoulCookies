module Api
  module Exceptions
    class InappropriateAddress < Exception
    end

    class I18n_m
      attr_accessor :klass, :instance
      def initialize(klass, instance)
        @klass = klass
        @instance = instance
      end
      def i18n_attributes
        i18l_hash = {}
        @instance.errors.messages.each do |k,v|
          i18l_hash["#{@klass.human_attribute_name(k)}"] = v.first
        end
        i18l_hash
      end
    end
  end
end
