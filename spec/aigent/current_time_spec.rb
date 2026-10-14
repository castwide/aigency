# frozen_string_literal: true

RSpec.describe Aigency::Aigent::CurrentTime do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  it 'formats iso8601 by default' do
    result = described_class.execute(aigent)
    expect(result[:success]).to be(true)
  end

  it 'formats unix timestamps' do
    result = described_class.execute(aigent, format: 'unix')
    expect(result[:success]).to be(true)
  end
end
