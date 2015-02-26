require 'spec_helper'

require 'bitmapped/bitmap'

describe Bitmap do

  subject { Bitmap.new }

  shared_examples_for "a command requiring an initialised bitmap" do |arg|
    it "returns an error message" do
      expect(subject.command([arg])).to eq("Bitmap has not been initialised, run command 'I' with valid arguments")
    end
  end

  describe 'the I command' do
    it 'initializes a grid of that size' do
      args = ["I", "2", "3"]
      pixels = [["0", "0"],
                ["0", "0"],
                ["0", "0"]]

      subject.command(args)

      expect(subject.columns).to eq(2)
      expect(subject.rows).to eq(3)
      expect(subject.pixels).to eq(pixels)
    end

    it 'overwrites the old bitmap given the I command again' do
      first_args = ["I", "2", "3"]
      second_args = ["I", "3", "2"]
      pixels = [["0", "0", "0"],
                ["0", "0", "0"]]

      subject.command(first_args)
      subject.command(second_args)

      expect(subject.columns).to eq(3)
      expect(subject.rows).to eq(2)
      expect(subject.pixels).to eq(pixels)
    end
  end

  describe 'the X command' do
    it 'raises an Interrupt exception' do
      expect{ subject.command(["X"]) } .to raise_error(Interrupt)
    end
  end

  describe 'the C command' do
    it_should_behave_like "a command requiring an initialised bitmap", "C"

    context 'when the bitmap is initialised' do
      it 'replaces all of the bitmap colors with "0"' do
        setup_pixels(subject, 3, 2, "X")
        subject.command(["C"])

        expect(subject.pixels).to eq([["0", "0", "0"],
                                      ["0", "0", "0"]])
      end
    end
  end

  describe 'the L command' do
    it_should_behave_like "a command requiring an initialised bitmap", "L"

    context 'when the bitmap is initialised' do
      before(:example) do
        setup_pixels(subject, 3, 2)
      end

      it 'replaces the color at those coordinates' do
        subject.command(["L", "1", "2", "Z"])
        subject.command(["L", "2", "1", "Z"])

        expect(subject.pixels).to eq([["0", "Z", "0"],
                                      ["Z", "0", "0"]])
      end

      it 'returns an error when the coordinates are not valid' do
        expect(subject.command(["L", "4", "4", "Z"])).to eq("Invalid co-ordinates")
      end
    end
  end

  describe 'the V command' do
    it_should_behave_like "a command requiring an initialised bitmap", "V"

    context 'when the bitmap is initialised' do
      before(:example) do
        setup_pixels(subject, 4, 4)
      end

      it 'should draw a vertical color segment between the 2 rows' do
        subject.command(["V", "3", "2", "4", "X"])
        subject.command(["V", "1", "1", "3", "Z"])

        expect(subject.pixels).to eq([["Z","0","0","0"],
                                      ["Z","0","X","0"],
                                      ["Z","0","X","0"],
                                      ["0","0","X","0"]]
          )
      end

      it 'returns an error when the coordinates are invalid' do
        [["V", "10", "1", "3", "Z"], ["V", "1", "10", "3", "Z"], ["V", "1", "1", "10", "Z"]].each do |args|
          expect(subject.command(args)).to eq("Invalid co-ordinates")
        end
      end

      it 'returns an error when the parameters are invalid' do
        [["V", "10", "3", "Z"], ["V", "Z", "10", "3", "3"], ["V", "1", "1", "10", "1"]].each do |args|
          expect(subject.command(args)).to eq("Invalid parameters")
        end
      end
    end
  end

  describe 'the H command' do
    it_should_behave_like "a command requiring an initialised bitmap", "H"

    context 'when the bitmap is initialised' do
      before(:example) do
        setup_pixels(subject, 4, 4)
      end

      it 'should draw a horizontal color segment between the 2 columns' do
        subject.command(["H", "2", "4", "2", "X"])
        subject.command(["H", "1", "4", "4", "Z"])

        expect(subject.pixels).to eq([["0","0","0","0"],
                                      ["0","X","X","X"],
                                      ["0","0","0","0"],
                                      ["Z","Z","Z","Z"]]
          )
      end

      it 'returns an error when the coordinates are invalid' do
        [["H", "10", "1", "3", "Z"], ["H", "1", "10", "3", "Z"], ["H", "1", "1", "10", "Z"]].each do |args|
          expect(subject.command(args)).to eq("Invalid co-ordinates")
        end
      end

      it 'returns an error when the parameters are invalid' do
        [["H", "10", "3", "Z"], ["H", "Z", "10", "3", "3"], ["H", "1", "1", "10", "1", "Z"]].each do |args|
          expect(subject.command(args)).to eq("Invalid parameters")
        end
      end
    end
  end

  describe 'the F command' do
    it_should_behave_like "a command requiring an initialised bitmap", "F"

    context 'when the bitmap is initialised' do

      before(:example) do
        setup_pixels(subject, 4, 4)
      end

      it 'should fill region on the bitmap with the color given' do
        subject.command(["F", "3", "3", "J"])
        expect(subject.pixels).to eq([["J","J","J","J"],
                                      ["J","J","J","J"],
                                      ["J","J","J","J"],
                                      ["J","J","J","J"]])
      end
    end
  end

  describe 'the S command' do
    it_should_behave_like "a command requiring an initialised bitmap", "S"

    context 'when the bitmap is initialised' do
      before(:example) do
        setup_pixels(subject, 4, 4)
      end

      let(:formatted_table) { %{+---+---+---+---+
                                | 0 | 0 | 0 | 0 |
                                | 0 | 0 | 0 | 0 |
                                | 0 | 0 | 0 | 0 |
                                | 0 | 0 | 0 | 0 |
                                +---+---+---+---+}.gsub(/[^\S\n]{2,}/, '')}

      let(:filled_formatted_table) {%{+---+---+---+---+
                                      | J | J | J | J |
                                      | J | J | J | J |
                                      | J | J | J | J |
                                      | J | J | J | J |
                                      +---+---+---+---+}.gsub(/[^\S\n]{2,}/, '')}

      it 'should output a formatted table' do
        expect(subject.command(["S"]).to_s).to eq(formatted_table)
      end

      it 'should output a correctly formatted table after fill command' do
        subject.command(["F", "3", "3", "J"])

        expect(subject.command(["S"]).to_s).to eq(filled_formatted_table)
      end
    end
  end

  def setup_pixels(subject, columns, rows, color="0")
    subject.columns = columns
    subject.rows = rows
    subject.pixels = Array.new(rows) { Array.new(columns) { color } }
  end
end