require 'bitmapped/exceptions'

module Bitmapped
  module Validators
    module ValidationHelper
      class << self
        def parse_color(color)
          color = color.strip
          if [*'A'..'Z'].include?(color)
            color
          else
            raise ParsingError
          end
        end
      end
    end
  end
end