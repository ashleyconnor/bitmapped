require 'spec_helper'

require 'bitmapped/exceptions'

describe Validators::ValidationHelper do

  subject { Validators::ValidationHelper }

  context 'given valid input' do

    let(:valid_inputs) { ["         A", "B", "C       "] }
    let(:outputs) { ["A", "B", "C"] }

    it 'should return an array of parsed values' do
      valid_inputs.each_with_index do |input, index|
        expect(subject.parse_color(input)).to eq(outputs[index])
      end
    end
  end

  context 'given invalid input' do

    let(:invalid_inputs) { ["2", "!", "a"] }

    it 'should return an error' do
      invalid_inputs.each do |input|
        expect{subject.parse_color(input)}.to raise_error(ParsingError)
      end
    end
  end
end