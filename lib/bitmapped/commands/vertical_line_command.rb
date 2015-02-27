require 'bitmapped/commands/base_command'
require 'bitmapped/commands/commands_helper'
require 'bitmapped/exceptions'

module Bitmapped
  module Commands
    class VerticalLineCommand < BaseCommand
      include CommandsHelper

      def command_id
        "V"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        column, start, finish, color = Validators::ValidateSegmentInput.parse_and_validate(input)
        vertical_command(bitmap, column, start, finish, color)
      end

      private
        def vertical_command(bitmap, column, x, y, color)
          raise InvalidCoordinatesError unless (0 < column && column <= bitmap.columns)
          x, y = coordinates_to_array_indexes(bitmap, x, y)
          column = column - 1
          bitmap.pixels[x..y].each { |row| row[column] = color }
        end
    end
  end
end