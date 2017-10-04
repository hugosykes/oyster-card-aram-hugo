require 'station'

describe Station do
  describe 'variables' do
    it 'should have a name' do
      expect(subject.name).to_not be_nil
    end

    it 'should have a zone' do
      expect((1..6)).to include(subject.zone)
    end
  end
end
