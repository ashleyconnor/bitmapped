module Bitmapped
  class Bitmap
    def command(parsed_input)
      case parsed_input.first
      when "I"
        puts "Initiate Command"
      when "C"
        puts "Clear Command"
      when "L"
        puts "Color Command"
      when "V"
        puts "Vertical Command"
      when "H"
        puts "Horizontal Command"
      when "F"
        puts "Fill Command"
      when "S"
        puts "Show Command"
      when "X"
        raise Interrupt
      else
        puts "Unknown Command"
      end
    end
  end
end