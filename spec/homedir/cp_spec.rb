# frozen_string_literal: true

RSpec.describe Aigency::Homedir::Cp do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  let(:copy_file) { File.join(aigent.data('homedir'), 'root_copy.txt') }

  after(:each) { File.unlink copy_file if File.file?(copy_file) }

  it 'copies a file' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['root.txt', 'root_copy.txt'])
    expect(result[:success]).to be(true)
    expect(File.file?(copy_file)).to be(true)
  end
end
