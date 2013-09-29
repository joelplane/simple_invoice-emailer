require 'spec_helper'

module SimpleInvoice::Emailer
  describe TextBody do

    let(:contact) do
      double 'contact', :name => "John Smith"
    end
    let(:line_items) do
      double 'line_items', :total => 110_00,
                           :to_a => [
                             double('line_item', :description => 'Gardening', :price => 50_00, :quantity => 1, :total => 50_00),
                             double('line_item', :description => 'Lawn Mowing', :price => 60_00, :quantity => 1, :total => 50_00)
                           ]
    end
    let(:invoice) do
      double 'invoice', :invoice_number => 123456,
                        :issue_date => "2013-01-02",
                        :due_date => "2013-01-09",
                        :contact => contact,
                        :line_items => line_items
    end
    let(:mail_config) do
      {:organisation_name => "Business"}
    end

    example do
      expected_output =
        "Dear John Smith\n" \
        "\n" \
        "This email is an invoice for services by Business.\n" \
        "\n" \
        "Invoice Number:  123456\n" \
        "    Amount Due:  $110.00\n" \
        "      Due Date:  2013-01-09\n" \
        "\n" \
        "Invoice Items:\n" \
        "+-------------+--------+----------+---------+\n" \
        "| Description | Price  | Quantity | Total   |\n" \
        "+-------------+--------+----------+---------+\n" \
        "| Gardening   | $50.00 |        1 |  $50.00 |\n" \
        "| Lawn Mowing | $60.00 |        1 |  $50.00 |\n" \
        "+-------------+--------+----------+---------+\n" \
        "| Total                           | $110.00 |\n" \
        "+-------------+--------+----------+---------+"
      SimpleInvoice::Emailer::TextBody.new(invoice, mail_config).email_body.strip.should == expected_output
    end

  end
end
