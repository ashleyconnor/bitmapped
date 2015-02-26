require 'bitmapped/exceptions'

module Bitmapped
  module Commands
    class HorizontalLineCommand < BaseCommand
      include CommandsHelper

      def command_id
        "H"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        column, start, finish, color = Validators::ValidateSegmentInput.parse_and_validate(input)
        horizontal_command(bitmap, column, start, finish, color)
      end

      private
        def horizontal_command(bitmap, x, y, row, color)
          raise InvalidCoordinatesError unless (0 < row && row <= bitmap.rows)
          x, y = coordinates_to_array_indexes(bitmap, x, y)
          row = row - 1
          bitmap.pixels[row][x..y] = Array.new((x..y).size, color)
        end
    end
  end
end