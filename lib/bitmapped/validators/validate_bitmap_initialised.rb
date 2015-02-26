require 'bitmapped/exceptions'
require 'bitmapped/validators/validation_helper'

module Bitmapped
  module Validators
    class ValidateBitmapInitialised

      class << self
        def parse_and_validate(bitmap)
          raise BitmapNotInitialised unless bitmap.pixels
        end
      end
    end
  end
end