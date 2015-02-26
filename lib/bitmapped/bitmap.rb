Dir[File.join(File.dirname(__FILE__), 'validators', '*.rb')].each {|file| require file }

require 'terminal-table'
require 'bitmapped/exceptions'

module Bitmapped
  class Bitmap

    attr_accessor :pixels, :table, :rows, :columns

    def command(input)
      begin
        case input.shift
        when "I"
          self.columns, self.rows = Validators::ValidateColumnRowInput.parse_and_validate(input)
          self.pixels = populate_pixels(self.columns, self.rows)
        when "X"
          raise Interrupt
        when bitmap_available("C")
          self.pixels = populate_pixels(self.columns, self.rows)
        when bitmap_available("L")
          column, row, color = Validators::ValidateFillInput.parse_and_validate(input)
          color_command(column, row, color)
        when bitmap_available("V")
          column, start, finish, color = Validators::ValidateSegmentInput.parse_and_validate(input)
          vertical_command(column, start, finish, color)
        when bitmap_available("H")
          start, finish, row, color = Validators::ValidateSegmentInput.parse_and_validate(input)
          horizontal_command(start, finish, row, color)
        when bitmap_available("F")
          column, row, color = Validators::ValidateFillInput.parse_and_validate(input)
          fill_command(column, row, color)
        when bitmap_available("S")
          formatted_table
        when "C", "L", "V", "H", "F", "S"
          "Bitmap has not been initialised, run command 'I' with valid arguments"
        else
          "Invalid Command"
        end
      rescue ParsingError => e
        "Invalid parameters"
      rescue InvalidCoordinatesError => e
        "Invalid co-ordinates"
      end
    end

    private
      def populate_pixels(x, y)
        Array.new(self.rows) { Array.new(self.columns) { "0" } }
      end

      def bitmap_available(command)
        lambda { |option| option == command && self.pixels }
      end

      def formatted_table
        self.table ||= Terminal::Table.new
        self.table.rows = self.pixels
        self.table
        # self.pixels.each { |row| puts row.join("") } # no fancy table
      end

      def color_command(x, y, color)
        x, y = coordinates_to_array_indexes(x, y)
        self.pixels[y][x] = color
      end

      def vertical_command(column, x, y, color)
        raise InvalidCoordinatesError unless (0 < column && column <= self.columns)
        x, y = coordinates_to_array_indexes(x, y)
        column = column - 1
        self.pixels[x..y].each { |row| row[column] = color }
      end

      def horizontal_command(x, y, row, color)
        raise InvalidCoordinatesError unless (0 < row && row <= self.rows)
        x, y = coordinates_to_array_indexes(x, y)
        row = row - 1
        self.pixels[row][x..y] = Array.new((x..y).size, color)
      end

      def fill_command(x, y, replacement_color)
        x, y = coordinates_to_array_indexes(x, y)
        target_color = self.pixels[x][y]
        queue = [[x,y]]

        until queue.empty?
          x, y = queue.pop
          next if (!valid_cooridinates(x+1, y+1) || self.pixels[x][y] != target_color)
          self.pixels[x][y] = replacement_color
          queue << [x+1, y] # east
          queue << [x-1, y] # west
          queue << [x, y+1] # south
          queue << [x, y-1] # north

          # and if we are doing 8-direction flood-fill...
          # queue << [x+1, y-1] # north-east
          # queue << [x-1, y-1] # north-west
          # queue << [x+1, y+1] # south-east
          # queue << [x-1, y+1] # south-west
        end
      end

      def valid_cooridinates(x, y)
        if (0 <= x && x <= self.columns) && (0 <= y && y <= self.rows)
          true
        else
          false
        end
      end

      def coordinates_to_array_indexes(x, y)
        x = x.to_i - 1
        y = y.to_i - 1
        if valid_cooridinates(x, y)
          [x, y]
        else
          raise InvalidCoordinatesError
        end
      end
  end
end