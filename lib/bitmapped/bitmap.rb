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
          puts formatted_table
        else
          puts "Invalid command"
        end
      rescue ParsingError => e
        puts "Invalid parameters"
      rescue InvalidCoordinatesError => e
        puts "Invalid co-ordinates"
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
        # self.pixels.each { |row| puts row.join('') } # no fancy table
      end

      def color_command(x, y, color)
        x, y = coordinates_to_array_indexes(x, y)
        self.pixels[y][x] = color
      end

      def vertical_command(column, x, y, color)
        x, y = coordinates_to_array_indexes(x, y)
        column = column.to_i - 1
        self.pixels[x..y].each { |row| row[column] = color }
      end

      def horizontal_command(x, y, row, color)
        x, y = coordinates_to_array_indexes(x, y)
        row = row.to_i - 1
        self.pixels[row][x..y] = Array.new((x..y).size, color)
      end

      def fill_command(x, y, replacement_color)
        x, y = coordinates_to_array_indexes(x, y)
        target_color = self.pixels[x][y]
        queue = [[x,y]]

        until queue.empty?
          x, y = queue.pop
          next if ((not [*0..self.columns].include?(x)) || (not [*0..self.rows].include?(y))) || self.pixels[x][y] != target_color
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
          raise InvalidCoordinatesError
        end
      end

      def coordinates_to_array_indexes(x, y)
        x = x.to_i - 1
        y = y.to_i - 1
        [x, y] if valid_cooridinates(x, y)
      end
  end
end