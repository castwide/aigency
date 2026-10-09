# frozen_string_literal: true

require 'fileutils'

RSpec.describe Aigency::Workspace::Mkdir do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  let(:new_dir) { File.join(aigent.data('workspace'), 'new_dir') }

  after(:each) { FileUtils.rm_rf new_dir if File.exist?(new_dir) }

  it 'makes a directory' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['new_dir'])
    expect(result[:success]).to be(true)
    expect(File.directory?(new_dir)).to be(true)
  end
end
