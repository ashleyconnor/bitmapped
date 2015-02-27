require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class ClearCommand < BaseCommand

      def command_id
        "C"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap.pixels = Array.new(bitmap.rows) { Array.new(bitmap.columns) { "O" } }
      end
    end
  end
end