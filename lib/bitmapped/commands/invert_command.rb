require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class InvertCommand < BaseCommand

      ALPHABET = [*'A'..'Z']

      def command_id
        "N"
      end

      def process_command(bitmap, input)
        Validators::ValidateBitmapInitialised.parse_and_validate(bitmap)
        bitmap.pixels.each_with_index do |row, index|
          bitmap.pixels[index] = row.collect{ |color| invert_color(color) }
        end
      end

      private
        def invert_color(color)
          ALPHABET[-(ALPHABET.index(color)+1)]
        end
    end
  end
end