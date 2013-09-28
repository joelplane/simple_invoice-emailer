module SimpleInvoice
  module Emailer
    class TextBody

      # @param invoice [SimpleInvoice::Invoice]
      def initialize invoice, organisation
        @invoice = invoice
        @organisation = organisation
      end

      # @return [String]
      def email_body
        salutation + "\n" +
        "\n" +
        preamble + "\n" +
        "\n" +
        invoice_data +
        "\n" +
        "Invoice Items:\n" +
        line_items_table +
        "\n" +
        postscript + "\n"
      end

      def salutation
        "Dear #{@invoice.contact.name}"
      end

      def preamble
        "This email is an invoice for services by #{@organisation.name}."
      end

      def postscript
        ""
      end

      def invoice_data
        list = TextList.new
        list.add 'Invoice Number', @invoice.invoice_number
        list.add 'Amount Due', dollars(@invoice.line_items.total)
        list.add 'Due Date', @invoice.due_date
        list.to_s
      end

      def line_items_table
        table = EmailInvoiceTextTable.new
        @invoice.line_items.to_a.each do |line_item|
          table.line_item :description => line_item.description,
                          :price => dollars(line_item.price),
                          :quantity => line_item.quantity,
                          :total => dollars(line_item.total)
        end
        table.total dollars(@invoice.line_items.total)
        table.to_s
      end

      # @param total_cents [Fixnum]
      # @return [String]
      def dollars total_cents
        dollar = total_cents / 100
        cents = total_cents % 100
        "$%d.%02d" % [dollar, cents]
      end

    end
  end
end
