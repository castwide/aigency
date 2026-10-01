# frozen_string_literal: true

RSpec.describe Aigency::Workspace::DirectoryReader do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'reads directories' do
    reader = described_class.new(aigent)
    result = reader.execute(directory_name: 'subdir')
    expect(result[:success]).to be(true)
    expect(result[:entries]).to eq(["file.txt", ".hidden"])
  end

  it 'handles non-existent directories' do
    reader = described_class.new(aigent)
    result = reader.execute(directory_name: 'workspace/foo/bar')
    expect(result[:success]).to be(false)
  end
end
