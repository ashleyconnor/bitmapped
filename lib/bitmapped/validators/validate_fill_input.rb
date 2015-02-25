require 'bitmapped/exceptions'
require 'bitmapped/validators/validation_helper'

module Bitmapped
  module Validators
    class ValidateFillInput

      class << self
        def parse_and_validate(input)
          begin
            columns = Integer(input[0])
            rows = Integer(input[1])
            color = ValidationHelper.parse_color(input[2].strip)
            [columns, rows, color]
          rescue ArgumentError => ae
            raise ParsingError
          end
        end
      end
    end
  end
end