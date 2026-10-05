# frozen_string_literal: true

RSpec.describe Aigency::Homedir::Grep do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'reads the root directory' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['--exclude-from=/nonexistent_zzz_zz/nope'])
    expect(result[:success]).to be(false)
    expect(result[:error]).to include('Permission denied: first argument must be [PATTERN]')
  end

  it 'validates subsequent paths' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['foo', '--exclude-from=/nonexistent_zzz_zz/nope'])
    expect(result[:success]).to be(false)
    expect(result[:error]).to include('PathError')
  end
end
