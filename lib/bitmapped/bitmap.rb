Dir[File.join(File.dirname(__FILE__), 'validators', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'commands', '*.rb')].each {|file| require file }

require 'bitmapped/exceptions'

module Bitmapped
  class Bitmap

    attr_accessor :pixels, :table, :rows, :columns

    def command(input)
      begin
        case input.shift
        when "I"
          Commands::InitialiserCommand.new.process_command(self, input)
        when "X", "exit"
          Commands::ExitCommand.new.process_command(self, input)
        when "C"
          Commands::ClearCommand.new.process_command(self, input)
        when "L"
          Commands::PixelFillCommand.new.process_command(self, input)
        when "V"
          Commands::VerticalLineCommand.new.process_command(self, input)
        when "H"
          Commands::HorizontalLineCommand.new.process_command(self, input)
        when "F"
          Commands::FillCommand.new.process_command(self, input)
        when "S"
          Commands::PrintTableCommand.new.process_command(self, input)
        when "T"
          Commands::PrintFancyTableCommand.new.process_command(self, input)
        when "R"
          Commands::RotateCommand.new.process_command(self, input)
        when "M"
          Commands::MirrorCommand.new.process_command(self, input)
        when "N"
          Commands::InvertCommand.new.process_command(self, input)
        else
          "Invalid Command"
        end
      rescue BitmapNotInitialised => bni
        "Bitmap has not been initialised, run command 'I' with valid arguments"
      rescue ParsingError => pe
        "Invalid parameters"
      rescue InvalidCoordinatesError => ice
        "Invalid co-ordinates"
      end
    end
  end
end