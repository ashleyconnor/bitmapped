require 'terminal-table'

module Bitmapped
  class Bitmap

    attr_accessor :pixels, :table, :rows, :columns

    def command(parsed_input)
      case parsed_input.shift
      when "I"
        self.columns = parsed_input[0].to_i
        self.rows = parsed_input[1].to_i
        self.pixels = populate_pixels(self.columns, self.rows)
      when "C"
        self.pixels = populate_pixels(self.columns, self.rows)
      when "L"
        color_command(parsed_input[0], parsed_input[1], parsed_input[2])
      when "V"
        vertical_command(parsed_input[0], parsed_input[1], parsed_input[2], parsed_input[3])
      when "H"
        horizontal_command(parsed_input[0], parsed_input[1], parsed_input[2], parsed_input[3])
      when "F"
        fill_command(parsed_input[0], parsed_input[1], parsed_input[2])
      when "S"
        pretty_print
      when "P"
        print_pixel(parsed_input[0], parsed_input[1])
      when "X"
        raise Interrupt
      else
        puts "Unknown Command"
      end
    end

    private
      def populate_pixels(x, y)
        Array.new(self.rows) { Array.new(self.columns) { "0" } }
      end

      def pretty_print
        self.table ||= Terminal::Table.new
        self.table.rows = self.pixels
        puts self.table
      end

      def color_command(x, y, color)
        x, y = *coordinates_to_array_indexes(x, y)
        self.pixels[y][x] = color
      end

      def vertical_command(column, x, y, color)
        x, y = *coordinates_to_array_indexes(x, y)
        column = column.to_i - 1
        self.pixels[x..y].each { |row| row[column] = color }
      end

      def horizontal_command(x, y, row, color)
        x, y = *coordinates_to_array_indexes(x, y)
        row = row.to_i - 1
        self.pixels[row][x..y] = Array.new((x..y).size, color)
      end

      def print_pixel(x, y)
        x, y = *coordinates_to_array_indexes(x, y)
        puts self.pixels[x][y]
      end

      def fill_command(x, y, replacement_color)
        x, y = *coordinates_to_array_indexes(x, y)
        target_color = self.pixels[x][y]
        queue = [[x,y]]

        until queue.empty?
          x, y = *queue.pop
          next if (x > self.columns || y > self.rows) || self.pixels[x][y] != target_color
          self.pixels[x][y] = replacement_color
          queue << [x+1, y] # east
          queue << [x-1, y] # west
          queue << [x, y+1] # south
          queue << [x, y-1] # north
        end
      end

      def coordinates_to_array_indexes(x, y)
        [x.to_i - 1, y.to_i - 1]
      end
  end
end