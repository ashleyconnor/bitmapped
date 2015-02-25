require 'bitmapped/exceptions'
require 'bitmapped/validators/validation_helper'

module Bitmapped
  module Validators
    class ValidateSegmentInput
      class << self
        def parse_and_validate(input)
          begin
            raise ArgumentError unless input.size == 4

            segement_a = Integer(input[0])
            segement_b = Integer(input[1])
            segement_c = Integer(input[2])
            color = ValidationHelper.parse_color(input[3].strip)
            [segement_a, segement_b, segement_c, color]
          rescue ArgumentError => ae
            raise ParsingError
          end
        end
      end
    end
  end
end