require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class PrintTableCommand < BaseCommand

      def command_id
        "S"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        table = bitmap.pixels.collect { |row| row.join("") }.join("\n")
        puts table
        table
      end
    end
  end
end