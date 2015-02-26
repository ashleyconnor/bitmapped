require 'spec_helper'

require 'bitmapped/exceptions'

describe Validators::ValidateBitmapInitialised do

  subject { Validators::ValidateBitmapInitialised }

  context 'given an initialised bitmap' do

    let(:bitmap) { Bitmap.new }

    it 'should not raise a BitmapNotInitialised error' do
      bitmap.command(["I", "4", "4"])

      expect{subject.parse_and_validate(bitmap)}.to_not raise_error
    end
  end

  context 'given an uninitialised bitmap' do

    let(:invalid_inputs) { [["A", "2"], ["2", "Z"], ["99"]] }

    it 'should raise a BitmapNotInitialised error' do
      invalid_inputs.each do |input|
        expect{Validators::ValidateColumnRowInput.parse_and_validate(input)}.to raise_error(ParsingError)
      end
    end
  end
end