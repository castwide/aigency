# frozen_string_literal: true

RSpec.describe Aigency::Workspace::Helpers do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  
  before(:each) { allow(described_class).to receive(:aigent).and_return(aigent) }

  describe '#validate_path_arguments' do
    it 'allows workspace root' do
      expect { described_class.validate_path_arguments(['.']) }.not_to raise_error
    end

    it 'allows long relative paths' do
      expect { described_class.validate_path_arguments(['foo/bar/baz.txt']) }.not_to raise_error
    end

    it 'rejects .. that resolves outside of workspace' do
      expect { described_class.validate_path_arguments(['../foo']) }.to raise_error(Aigency::PathError)
    end

    it 'allows relative paths in --arg=path' do
      expect { described_class.validate_path_arguments(['--arg=foo/bar/baz.txt']) }.not_to raise_error
    end

    it 'rejects invalid paths in --arg=path' do
      expect { described_class.validate_path_arguments(['--arg=/foo/bar/baz.txt']) }.to raise_error(Aigency::PathError)
    end

    it 'rejects invalid paths in glued short options' do
      expect { described_class.validate_path_arguments(['-r/foo']) }.to raise_error(Aigency::PathError)
    end

    it 'rejects invalid paths in clustered glued short options' do
      expect { described_class.validate_path_arguments(['-tvr/foo']) }.to raise_error(Aigency::PathError)
    end
  end
end
