require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class RotateCommand < BaseCommand

      def command_id
        "R"
      end

      def process_command(bitmap, _)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap.pixels = bitmap.pixels.transpose.map &:reverse
      end
    end
  end
end