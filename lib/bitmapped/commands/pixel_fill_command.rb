require 'bitmapped/commands/base_command'
require 'bitmapped/commands/commands_helper'
require 'bitmapped/exceptions'

module Bitmapped
  module Commands
    class PixelFillCommand < BaseCommand
      include CommandsHelper

      def command_id
        "L"
      end

      def process_command(bitmap, input)
          Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
          column, row, color = Validators::ValidateFillInput.parse_and_validate(input)
          color_command(bitmap, column, row, color)
      end

      private
        def color_command(bitmap, x, y, color)
          x, y = coordinates_to_array_indexes(bitmap, x, y)
          bitmap.pixels[y][x] = color
        end
    end
  end
end