require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    module CommandsHelper
      def valid_cooridinates(bitmap, x, y)
        if (0 <= x && x <= bitmap.columns) && (0 <= y && y <= bitmap.rows)
          true
        else
          false
        end
      end

      def coordinates_to_array_indexes(bitmap, x, y)
        x = x.to_i - 1
        y = y.to_i - 1
        if valid_cooridinates(bitmap, x, y)
          [x, y]
        else
          raise InvalidCoordinatesError
        end
      end
    end
  end
end