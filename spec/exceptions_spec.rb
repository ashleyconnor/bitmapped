require 'spec_helper'

require 'bitmapped/exceptions'

describe ParsingError do
  subject { ParsingError }

  it 'inherits from StandardError' do
    expect(subject.superclass).to eq(StandardError)
  end
end

describe InvalidCoordinatesError do
  subject { InvalidCoordinatesError }

  it 'inherits from StandardError' do
    expect(subject.superclass).to eq(StandardError)
  end
end

