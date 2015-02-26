require 'bitmapped/exceptions'

module Bitmapped
  module Validators
    module ValidationHelper

      ALPHABET = [*'A'..'Z']

      class << self
        def parse_color(color)
          color = color.strip
          if ALPHABET.include?(color)
            color
          else
            raise ParsingError
          end
        end
      end
    end
  end
end