require 'text-table'

module SimpleInvoice
  module Emailer
    class TextList

      def initialize
        @table = Text::Table.new :horizontal_padding    => 1,
                                 :vertical_boundary     => ' ',
                                 :horizontal_boundary   => ' ',
                                 :boundary_intersection => ' '
        @table.rows = []
      end

      def add label, value
        @table.rows << [{:value => "#{label}:", :align => :right}, value.to_s]
      end

      def to_s
        reduce_gap(unindent(remove_empty_lines(@table.to_s))) + "\n"
      end

      private

      def remove_empty_lines str
        str.gsub(/\n\s+\n/, "\n").gsub(/^\s+\n/, "")
      end

      # also removes trailing spaces from each line
      def unindent str
        lines = str.split("\n")
        spaces = minimum_leading_spaces lines
        lines.collect do |line|
          line.slice(spaces, line.length).rstrip
        end.join("\n")
      end

      def minimum_leading_spaces lines
        lines.collect do |line|
          /^\s+/.match(line).to_s.length
        end.min
      end

      def reduce_gap str
        str.gsub(':   ', ':  ')
      end
    end
  end
end
