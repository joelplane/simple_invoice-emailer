require 'spec_helper'

module SimpleInvoice::Emailer
  describe EmailInvoiceTextTable do

    example do
      expected_output =
        "+-------------+--------+----------+---------+\n" \
        "| Description | Price  | Quantity | Total   |\n" \
        "+-------------+--------+----------+---------+\n" \
        "| Gardening   | $50.00 |        1 |  $50.00 |\n" \
        "| Lawn Mowing | $60.00 |        1 |  $60.00 |\n" \
        "+-------------+--------+----------+---------+\n" \
        "| Total                           | $110.00 |\n" \
        "+-------------+--------+----------+---------+\n"
      table = EmailInvoiceTextTable.new
      table.line_item :description => 'Gardening', :price => "$50.00", :quantity => 1, :total => "$50.00"
      table.line_item :description => 'Lawn Mowing', :price => "$60.00", :quantity => 1, :total => "$60.00"
      table.total "$110.00"
      table.to_s.should == expected_output
    end

  end
end
