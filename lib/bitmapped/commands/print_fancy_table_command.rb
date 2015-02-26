require 'terminal-table'

module Bitmapped
  module Commands
    class PrintFancyTableCommand < BaseCommand

      def command_id
        "T"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap.table ||= Terminal::Table.new
        bitmap.table.rows = bitmap.pixels
        bitmap.table
      end
    end
  end
end