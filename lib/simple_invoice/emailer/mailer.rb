module SimpleInvoice
  module Emailer
    class Mailer

      # @param mail_config [SimpleInvoice::Emailer::MailConfig]
      def initialize mail_config=MailConfig
        @mail_config = mail_config
      end

      # @param invoice [SimpleInvoice::Invoice]
      def deliver! invoice
        mail_instance(invoice).deliver
      end

      private

      def mail_instance invoice
        _email_from = get_config(:email_from)
        _email_bcc = get_optional_config(:email_bcc)
        _email_subject = email_subject(invoice)
        _email_body = email_body(invoice)
        Mail.new do
          to invoice.contact.email
          from _email_from
          bcc _email_bcc if _email_bcc
          subject _email_subject
          body _email_body
        end
      end

      def email_body invoice
        TextBody.new(invoice, @mail_config).email_body
      end

      def email_subject invoice
        get_config(:email_subject)[invoice]
      end

      def get_config key
        get_optional_config(key).tap do |value|
          raise "Missing config key #{key}" if value.nil?
        end
      end

      def get_optional_config key
        @mail_config[key]
      end

    end
  end
end
