# frozen_string_literal: true

RSpec.describe Aigency::Homedir::Ls do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'reads the root directory' do
    reader = described_class.new(aigent)
    result = reader.execute
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('root.txt')
    expect(result[:stdout]).to include('subdir')
  end

  it 'changes directories' do
    reader = described_class.new(aigent)
    result = reader.execute(directory: 'subdir')
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('inner.txt')
  end

  it 'uses the -l argument' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['-l'])
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('total 4')
    expect(result[:stdout]).to include('root.txt')
    expect(result[:stdout]).to include('subdir')
  end
end
