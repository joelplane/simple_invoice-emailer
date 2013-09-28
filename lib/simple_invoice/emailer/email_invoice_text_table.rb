require 'text-table'

module SimpleInvoice
  module Emailer
    class EmailInvoiceTextTable

      def initialize
        @table = Text::Table.new
        @table.rows = []
        @invoice_rows = []
      end

      def line_item values
        @invoice_rows << values.values_at(*[:description, :price, :quantity, :total]).collect(&:to_s)
      end

      def total total
        @total = total
      end

      # @return [String]
      def text_table
        @table.head = left ['Description', 'Price', 'Quantity', 'Total']
        set_column_alignments [:left, :right, :right, :right]
        @invoice_rows.each do |row|
          add_row row
        end
        @table.foot = [{:value => 'Total', :colspan => 3}, right(@total)]
        @table
      end

      def to_s
        text_table.to_s
      end

      private

      def set_column_alignments alignments
        @alignments = alignments
      end

      # @param row [Array<String>]
      def add_row row
        rows = rows_multi_line row
        rows.each do |row|
          @table.rows << row_with_alignments(row)
        end
      end

      # @param row [Array<String>]
      def rows_multi_line row
        if (n = number_of_lines row) > 1
          split_into_lines = row.collect do |value|
            value.split("\n")
          end
          (0...n).collect do |index|
            split_into_lines.collect do |lines|
              lines[index]
            end
          end
        else
          [row]
        end
      end

      # @param row [Array<String>]
      def number_of_lines row
        row.collect do |value|
          value.count "\n"
        end.max + 1
      end

      # @param row [Array<String>]
      # @return [Array<Hash>]
      def row_with_alignments row
        row.zip(@alignments).collect do |value, alignment|
          align value, alignment
        end
      end

      # @param value [String]
      # @return [Hash]
      def left value
        align value, :left
      end

      # @param value [String]
      # @return [Hash]
      def right value
        align value, :right
      end

      # @param value [String, Array<String>]
      # @param alignment [Symbol]
      # @return [Hash, Array<Hash>]
      def align value, alignment
        if value.is_a? Array
          value.collect do |val|
            align val, alignment
          end
        else
          {:value => value, :align => alignment}
        end
      end

    end
  end
end
