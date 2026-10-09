# frozen_string_literal: true

RSpec.describe Aigency::Tempdir::Read do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  before(:each) { File.write File.join(Aigency::Tempdir::PATH, 'test.txt'), 'Test file' }
  after(:each) { File.unlink File.join(Aigency::Tempdir::PATH, 'test.txt') }

  it 'reads a file' do
    result = described_class.new(aigent).execute(filename: 'test.txt')
    expect(result[:success]).to be(true)
    expect(result[:content]).to eq('Test file')
  end
end
