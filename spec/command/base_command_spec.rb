require 'spec_helper'

describe 'BaseCommand' do

  subject { Commands::BaseCommand.new }

  context 'as an abstract class' do
    it 'raises a NotImplementedError on any methods called' do
      expect{subject.command_id}.to raise_error(NotImplementedError)
      expect{subject.process_command(nil, nil)}.to raise_error(NotImplementedError)
    end
  end
end