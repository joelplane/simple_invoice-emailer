module SimpleInvoice::Emailer
  describe Mailer do

    let :mail_config do
      email_subject = lambda do |invoice|
        "Invoice ##{invoice.invoice_number}"
      end
      {
        :email_subject => email_subject,
        :email_from => 'accounts@example.com'
      }
    end

    let :contact do
      double 'contact', :name => "John Smith", :email => 'john.smith@customer.example.com'
    end

    let :line_items do
      double 'line_items', :total => 110_00,
                           :to_a => [
                             double('line_item', :description => 'Gardening', :price => 50_00, :quantity => 1, :total => 50_00),
                             double('line_item', :description => 'Lawn Mowing', :price => 60_00, :quantity => 1, :total => 50_00)
                           ]
    end

    let :invoice do
      double 'invoice', :invoice_number => 123456,
                        :issue_date => "2013-01-02",
                        :due_date => "2013-01-09",
                        :contact => contact,
                        :line_items => line_items
    end


    subject do
      Mailer.new(mail_config).tap do |mailer|
        mailer.stub(:email_body => 'body')
      end
    end

    example do
      mail = subject.send(:mail_instance, invoice)
      mail.should be_a Mail::Message
      mail.subject.should == 'Invoice #123456'
      mail.body.should == 'body'
      mail.from.should == ['accounts@example.com']
    end

  end
end
