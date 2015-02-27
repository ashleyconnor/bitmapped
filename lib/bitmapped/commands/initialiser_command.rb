require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class InitialiserCommand < BaseCommand

      def command_id
        "I"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapSize.parse_and_validate(input)
        bitmap.columns, bitmap.rows = Validators::ValidateColumnRowInput.parse_and_validate(input)
        bitmap.pixels = Array.new(bitmap.rows) { Array.new(bitmap.columns) { "O" } }
      end
    end
  end
end