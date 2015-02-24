require 'spec_helper'
require 'bitmapped'

describe Bitmapped do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).not_to be_empty
  end
  it "should have a type Pixel" do
    pixel = Pixel.new("S", 1, 2)
  end

  it "pixel should respond to #to_s" do
    expect(Pixel.new("S", 1, 2).to_s).to eq("S")
  end
end
