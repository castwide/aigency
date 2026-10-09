# frozen_string_literal: true

require 'tmpdir'

RSpec.describe Aigency::Aigent do
  let(:aigent_directory) { File.join('spec', 'fixtures', 'aigent') }
  let(:aigent) { described_class.new(aigent_directory) }

  describe "#config" do
    it 'loads a config file' do
      config = aigent.config('example')
      expect(config['name']).to eq('example')
      expect(config['emails']).to eq(['one@example.com', 'two@example.com'])
    end

    it 'loads environment variables' do
      config = aigent.config('aigent')
      expect(config['openai_api_base']).to eq('https://api.openai.com/v1')
    end

    it 'raises KeyError on missing environment variables' do
      expect { aigent.config('error') }.to raise_error(KeyError)
    end
  end

  describe '#name' do
    it 'has a default name' do
      Dir.mktmpdir do |dir|
        aigent = described_class.new(dir)
        expect(aigent.name).to eq('an Aigent')        
      end
    end

    it 'has a configured name' do
      expect(aigent.name).to eq('Example Aigent')
    end
  end

  describe '#setup' do
    it 'creates config files' do
      skip 'aigent.yml is not a plugin config'
      Dir.mktmpdir do |tmpdir|
        aigent = described_class.new(tmpdir)
        config_file = File.join(tmpdir, 'config', 'aigent.yml')
        expect(File.file?(config_file)).to be(false)
        aigent.setup
        expect(File.file?(config_file)).to be(true)
      end
    end
  end

  describe '#busy?' do
    it 'returns false by default' do
      expect(aigent).not_to be_busy
    end

    it 'returns true in a lock' do
      aigent.lock do
        expect(aigent).to be_busy
      end
      expect(aigent).not_to be_busy
    end
  end

  describe '#nonblock' do
    it 'executes without a lock' do
      executed = false
      aigent.nonblock { executed = true }
      expect(executed).to be(true)
    end

    it 'skips without executing in a lock' do
      executed = nil
      aigent.lock do
        executed = false
        aigent.nonblock { executed = true }
      end
      expect(executed).to be(false)
    end
  end

  describe '#instructions' do
    it 'includes tool prompts' do
      expect(aigent.instructions).to include('How to use example')
    end
  end

  describe '#plugins' do
    it 'returns configured plugins' do
      expect(aigent.plugins.map(&:name)).to eq(['homedir', 'docker'])
    end
  end

  describe '#tools' do
    let(:all_tools) {
      [Aigency::Homedir::Cat, Aigency::Homedir::Cp, Aigency::Homedir::Diff, Aigency::Homedir::Grep, Aigency::Homedir::Ls, Aigency::Homedir::Mkdir, Aigency::Homedir::Mv, Aigency::Homedir::Rm, Aigency::Homedir::Wc, Aigency::Homedir::Write, Aigency::Docker::Compose::Run]
    }

    it 'reads tools from plugins' do
      expect(aigent.tools).to match_array(all_tools)
    end
  end
end
