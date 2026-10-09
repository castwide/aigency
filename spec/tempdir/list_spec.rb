# frozen_string_literal: true

RSpec.describe Aigency::Tempdir::List do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  before(:each) { File.write File.join(Aigency::Tempdir::PATH, 'test.txt'), 'Test file' }
  after(:each) { File.unlink File.join(Aigency::Tempdir::PATH, 'test.txt') }

  it 'lists files' do
    result = described_class.new(aigent).execute
    expect(result[:success]).to be(true)
    expect(result[:absolute_paths]).to include(File.join(Aigency::Tempdir::PATH, 'test.txt'))
  end
end
