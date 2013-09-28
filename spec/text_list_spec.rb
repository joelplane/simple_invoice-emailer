require 'spec_helper'

module SimpleInvoice::Emailer
  describe TextList do

    example do
      expected_output =
        "Invoice Number:  123456\n" \
        "    Amount Due:  $1,100.00\n" \
        "      Due Date:  2013-01-01\n"
      list = TextList.new
      list.add 'Invoice Number', 123456
      list.add 'Amount Due', '$1,100.00'
      list.add 'Due Date', '2013-01-01'
      list.to_s.should == expected_output
    end

  end
end
