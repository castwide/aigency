# frozen_string_literal: true

RSpec.describe Aigency::Workspace::Write do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  let(:test_file) { File.join(aigent.data('workspace'), 'test.txt') }

  after(:each) { File.unlink test_file if File.file?(test_file) }

  it 'writes a file' do
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'test.txt', content: 'Hello, world!', append: false)
    expect(result[:success]).to be(true)
    expect(File.read(test_file)).to eq('Hello, world!')
  end

  it 'fails for nonexistent directories' do
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'not_real/test.txt', content: 'Hello, world!', append: false)
    expect(result[:success]).to be(false)
  end

  it 'appends to existing files' do
    File.write test_file, 'Hello, '
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'test.txt', content: 'world!', append: true)
    expect(File.read(test_file)).to eq('Hello, world!')
  end

  it 'overwrites files' do
    File.write test_file, 'Helllo, world!'
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'test.txt', content: 'Goodbye, world!', append: false)
    expect(File.read(test_file)).to eq('Goodbye, world!')
  end
end
