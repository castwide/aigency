# frozen_string_literal: true

RSpec.describe Aigency::Tempdir::Write do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  after(:each) { File.unlink File.join(Aigency::Tempdir::PATH, 'test.txt') }

  it 'writes a file' do
    result = described_class.new(aigent).execute(filename: 'test.txt', content: 'Test file')
    expect(result[:success]).to be(true)
    expect(File).to be_file(File.join(Aigency::Tempdir::PATH, 'test.txt'))
  end
end
