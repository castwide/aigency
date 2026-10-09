# frozen_string_literal: true

RSpec.describe Aigency::Workspace::Grep do
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

  it 'works with --help' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['--help'])
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('Usage: grep')
  end

  it 'restricts arguments' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['foo', '--file', 'bar'])
    expect(result[:success]).to be(false)
    expect(result[:error]).to include("arguments to `grep` are prohibited")
  end
end
