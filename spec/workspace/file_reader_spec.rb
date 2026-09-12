# frozen_string_literal: true

RSpec.describe Aigency::Workspace::FileReader do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'reads files' do
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'subdir/file.txt')
    expect(result[:success]).to be(true)
    expect(result[:content]).to eq('Subdir file')
  end

  it 'handles non-existent files' do
    reader = described_class.new(aigent)
    result = reader.execute(filename: 'notreal.txt')
    expect(result[:success]).to be(false)
  end
end
