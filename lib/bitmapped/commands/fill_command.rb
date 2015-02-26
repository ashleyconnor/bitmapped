require 'bitmapped/exceptions'

module Bitmapped
  module Commands
    class FillCommand < BaseCommand
      include CommandsHelper

      def command_id
        "F"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        column, row, color = Validators::ValidateFillInput.parse_and_validate(input)
        fill_command(bitmap, column, row, color)
      end

      private
        def fill_command(bitmap, x, y, replacement_color)
          x, y = coordinates_to_array_indexes(bitmap, x, y)
          target_color = bitmap.pixels[x][y]
          queue = [[x,y]]

          until queue.empty?
            x, y = queue.pop
            next if (!valid_cooridinates(bitmap, x+1, y+1) || bitmap.pixels[x][y] != target_color)
            bitmap.pixels[x][y] = replacement_color
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
    end
  end
end