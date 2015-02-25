require 'bitmapped/exceptions'

module Bitmapped
  module Validators
    class ValidateColumnRowInput
      class << self
        def parse_and_validate(input)
          begin
            columns = Integer(input[0])
            rows = Integer(input[1])
            [columns, rows]
          rescue ArgumentError => ae
            raise ParsingError
          end
        end
      end
    end
  end
end