module Bitmapped
  class Pixel < Struct.new(:color, :x, :y)
    def to_s
      color
    end
  end
end