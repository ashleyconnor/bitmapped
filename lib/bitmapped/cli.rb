require 'bitmapped/bitmap'

require 'readline'

module Bitmapped
  class Cli
    class << self
      def start
        begin
          bitmap = Bitmap.new
          puts "Bitmapped Command Centre (Ctrl+C to exit):"

          loop do
            input = parse_input(Readline.readline("> "))
            bitmap.command(input)
          end
        rescue Interrupt => interrupt
          puts "\nExiting..."
          exit
        end
      end

      def parse_input(input)
        input.strip.split(' ')
      end
    end
  end
end