require 'station'

describe Station do
  let(:subject) { described_class.new('Victoria', 1) }
  describe 'variables' do
    it 'should have a name' do
      expect(subject.name).to eq 'Victoria'
    end

    it 'should have a zone' do
      expect(subject.zone).to eq 1
    end
  end
end
