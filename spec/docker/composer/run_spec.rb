# frozen_string_literal: true

RSpec.describe Aigency::Docker::Compose::Run do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'runs in the container' do
    run = described_class.new(aigent)
    result = run.execute(command: 'ls')
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('root.txt')
    expect(result[:stdout]).to include('subdir')
  end
end
