module SimpleInvoice
  module Emailer
    class MailConfig

      class << self

        extend Forwardable
        def_delegator :instance, :[]

        def instance
          @instance ||= new
        end

        # @param email [String]
        def email_from email
          instance[:email_from] = email
        end

        # @param subject [#call]
        def email_subject subject
          instance[:email_subject] = subject
        end

        # @param name [String]
        def organisation_name name
          instance[:organisation_name] = name
        end

      end

      def initialize
        @config_hash = {}
      end

      def [](key)
        @config_hash[key]
      end

      def []=(key, value)
        @config_hash[key] = value
      end
    end
  end
end


