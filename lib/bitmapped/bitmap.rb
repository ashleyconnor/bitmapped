require 'terminal-table'

module Bitmapped
  class Bitmap

    attr_accessor :pixels, :rows, :columns

    def command(parsed_input)
      case parsed_input.shift
      when "I"
        populate_pixels(parsed_input[0], parsed_input[1])
      when "C"
        populate_pixels(self.columns, self.rows)
      when "L"
        color_command(parsed_input[0], parsed_input[1], parsed_input[2])
      when "V"
        vertical_command(parsed_input[0], parsed_input[1], parsed_input[2], parsed_input[3])
      when "H"
        horizontal_command(parsed_input[0], parsed_input[1], parsed_input[2], parsed_input[3])
      when "F"
        puts "Fill Command"
      when "S"
        pretty_print
      when "X"
        raise Interrupt
      else
        puts "Unknown Command"
      end
    end

    private
      def populate_pixels(x, y)
        self.columns = x.to_i
        self.rows = y.to_i
        self.pixels = Array.new(self.rows) { Array.new(self.columns) { "0" } }
      end

      def pretty_print
        @table = Terminal::Table.new
        @table.rows = self.pixels
        puts @table
      end

      def color_command(x, y, color)
        self.pixels[y.to_i - 1][x.to_i - 1] = color
      end

      def vertical_command(column, x, y, color)
        x = x.to_i - 1
        y = y.to_i - 1
        column = column.to_i - 1
        self.pixels[x..y].each { |row| row[column] = color }
      end

      def horizontal_command(x, y, row, color)
        x = x.to_i - 1
        y = y.to_i - 1
        row = row.to_i - 1
        self.pixels[row][x..y] = Array.new((x..y).size, color)
      end

      def fill_command
        # horizontal array
      end
  end
end