module Bitmapped
  module Commands
    class BaseCommand
      def command_id
        raise NotImplementedError.new("You must implement command_id.")
      end

      def process_command(pixels, args)
        raise NotImplementedError.new("You must implement process_command.")
      end
    end
  end
end