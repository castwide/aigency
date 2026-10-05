# frozen_string_literal: true

RSpec.describe Aigency::Homedir::Rm do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }
  let(:test_file) { File.join(aigent.data('homedir'), 'test.txt') }

  before(:each) { File.write test_file, 'test' }
  after(:each) { File.unlink test_file if File.file?(test_file) }

  it 'deletes a file' do
    reader = described_class.new(aigent)
    result = reader.execute(arguments: ['test.txt'])
    puts result.inspect
    expect(result[:success]).to be(true)
    expect(File.file?(test_file)).to be(false)
  end
end
