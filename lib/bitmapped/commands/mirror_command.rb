module Bitmapped
  module Commands
    class MirrorCommand < BaseCommand

      def command_id
        "R"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap = bitmap.pixels.collect { |row| row.reverse! }
      end
    end
  end
end