module SimpleInvoice
  module Emailer

    autoload :TextBody, "simple_invoice/emailer/text_body"
    autoload :EmailInvoiceTextTable, "simple_invoice/emailer/email_invoice_text_table"
    autoload :TextList, "simple_invoice/emailer/text_list"

    # @param invoice [SimpleInvoice::Invoice]
    def self.deliver invoice

    end

  end
end