# frozen_string_literal: true

RSpec.describe Aigency::Workspace::Helpers do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  let(:klass) do
    Class.new do
      include Aigency::Workspace::Helpers
      attr_reader :aigent
      def initialize aigent
        @aigent = aigent
      end
    end
  end

  let(:object) { klass.new(aigent) }

  describe '#expand_to_workspace' do
    it 'returns absolute paths' do
      path = object.expand_to_workspace('foo/bar.txt')
      expect(path).to eq(File.join(aigent.data('workspace'), 'foo/bar.txt'))
    end

    it 'denies permission to paths outside of workspace' do
      expect { object.expand_to_workspace('../config') }.to raise_error(Aigency::Workspace::PathError)
    end
  end
end
