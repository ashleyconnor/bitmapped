require 'bitmapped/exceptions'
require 'bitmapped/validators/validation_helper'

module Bitmapped
  module Validators
    class ValidateBitmapSize
      class << self
        def parse_and_validate(input)
          begin
            columns, rows = Validators::ValidateColumnRowInput.parse_and_validate(input)
            raise ArgumentError unless ((0 < columns && columns <= 250) && (0 < rows && rows <= 250))
          rescue ArgumentError => ae
            raise ParsingError
          end
        end
      end
    end
  end
end