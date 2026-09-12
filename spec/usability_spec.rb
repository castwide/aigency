# frozen_string_literal: true

RSpec.describe Aigency::Usability do
  let(:klass) do
    Class.new do
      include Aigency::Usability

      def execute
        :ok
      end
    end
  end

  it 'has an execute class method' do
    expect(klass.execute(nil)).to be(:ok)
  end
end
