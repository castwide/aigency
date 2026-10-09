# frozen_string_literal: true

RSpec.describe Aigency::Sandbox::Exec do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { Aigency::Aigent.new(aigent_directory) }

  # before(:all) { `cd #{File.join('spec', 'fixtures', 'aigent')} && docker compose up -d`}
  # after(:all) { `cd #{File.join('spec', 'fixtures', 'aigent')} && docker compose down`}

  it 'runs commands in the sandbox' do
    pending 'WIP'
    run = described_class.new(aigent)
    result = run.execute(command: 'ls')
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('root.txt')
    expect(result[:stdout]).to include('subdir')
  end

  it 'runs commands with arguments in the sandbox' do
    pending 'WIP'
    run = described_class.new(aigent)
    result = run.execute(command: 'ls -al')
    expect(result[:success]).to be(true)
    expect(result[:stdout]).to include('root.txt')
    expect(result[:stdout]).to include('subdir')
  end
end
