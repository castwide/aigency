# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'

RSpec.describe Aigency::Workspace::FileWriter do
  before(:each) do @tmpdir = Dir.mktmpdir
    FileUtils.mkdir_p File.join(@tmpdir, 'data', 'workspace')
  end

  after(:each) { FileUtils.rm_rf @tmpdir }

  let(:aigent) { Aigency::Aigent.new(@tmpdir) }

  it 'writes files' do
    writer = described_class.new(aigent)
    result = writer.execute(filename: 'file.txt', content: 'New file')
    expect(result[:success]).to be(true)
    expect(File.read(File.join(@tmpdir, 'data', 'workspace', 'file.txt'))).to eq('New file')
  end

  it 'rejects prohibited paths' do
    writer = described_class.new(aigent)
    result = writer.execute(filename: '../file.txt', content: 'Invalid file')
    expect(result[:success]).to be(false)
    expect(result[:error]).to include('Permission denied')
  end

  it 'handles invalid paths' do
    writer = described_class.new(aigent)
    result = writer.execute(filename: '/root/file.txt', content: 'Invalid file')
    expect(result[:success]).to be(false)
  end
end
