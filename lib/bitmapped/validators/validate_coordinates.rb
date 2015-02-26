require 'bitmapped/exceptions'
require 'bitmapped/validators/validation_helper'

module Bitmapped
  module Validators
    class ValidateCoordinates
      class << self
        def parse_and_validate(bitmap, input)
          begin
            row = Integer(input[0])
            column = Integer(input[1])
            raise InvalidCoordinatesError unless bitmap.pixels[row][column]
          rescue NoMethodError => nme
            raise InvalidCoordinatesError
          end
        end
      end
    end
  end
end