require 'mail'

module SimpleInvoice
  module Emailer

    autoload :TextBody, "simple_invoice/emailer/text_body"
    autoload :EmailInvoiceTextTable, "simple_invoice/emailer/email_invoice_text_table"
    autoload :TextList, "simple_invoice/emailer/text_list"
    autoload :Mailer, "simple_invoice/emailer/mailer"
    autoload :MailConfig, "simple_invoice/emailer/mail_config"

    # @param invoice [SimpleInvoice::Invoice]
    def self.deliver! invoice
      Mailer.new.deliver! invoice
    end

  end
end