require 'spec_helper'

require 'bitmapped/exceptions'

describe Validators::ValidateFillInput do

  subject { Validators::ValidateFillInput }

  context 'given valid input' do

    let(:valid_inputs) { [["2", "2", "C"], ["2", "3", "X"], ["10", "99", "Y"]] }
    let(:outputs) { [[2, 2, "C"], [2, 3, "X"], [10, 99, "Y"]] }

    it 'should return an array of parsed values' do
      valid_inputs.each_with_index do |input, index|
        expect(subject.parse_and_validate(input)).to eq(outputs[index])
      end
    end
  end

  context 'given invalid input' do

    let(:invalid_inputs) { [["A", "2", "2"], ["2", "Z", "A"], ["99", "Z"]] }

    it 'should return an error' do
      invalid_inputs.each do |input|
        expect{subject.parse_and_validate(input)}.to raise_error(ParsingError)
      end
    end
  end
end