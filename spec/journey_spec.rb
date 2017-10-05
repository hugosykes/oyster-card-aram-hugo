require 'Journey'
describe Journey do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:subject) { described_class.new(entry_station, exit_station) }
  describe 'stations' do
    it 'should have an entry station' do
      expect(subject).to respond_to :entry_station
    end

    it 'should have an exit station' do
      expect(subject).to respond_to :exit_station
    end
  end
end
