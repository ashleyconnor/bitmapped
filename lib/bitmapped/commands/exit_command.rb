require 'bitmapped/commands/base_command'

module Bitmapped
  module Commands
    class ExitCommand < BaseCommand

      def command_id
        "X"
      end

      def process_command(bitmap, input)
        raise Interrupt
      end
    end
  end
end