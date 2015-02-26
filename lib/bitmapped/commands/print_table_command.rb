require 'terminal-table'

module Bitmapped
  module Commands
    class PrintTableCommand < BaseCommand

      def command_id
        "S"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap.pixels.collect { |row| row.join("") }.join("\n")
      end
    end
  end
end