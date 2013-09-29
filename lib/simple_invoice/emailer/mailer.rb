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
        _email_from = @mail_config[:email_from]
        _email_subject = email_subject(invoice)
        _email_body = email_body(invoice)
        Mail.new do
          to invoice.contact.email
          from _email_from
          subject _email_subject
          body _email_body
        end
      end

      def email_body invoice
        TextBody.new(invoice, @mail_config).email_body
      end

      def email_subject invoice
        @mail_config[:email_subject][invoice]
      end

    end
  end
end
