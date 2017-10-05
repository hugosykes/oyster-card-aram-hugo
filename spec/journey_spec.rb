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

  describe '#end_journey' do
    let(:subject) { described_class.new(entry_station) }
    before { subject.end_journey(exit_station) }
    it 'should accept an exit station as an argument for end_journey and set it as the exit station' do
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
    it 'should respond to the fare method' do
      expect(subject).to respond_to :fare
    end

    context 'normal journey' do
      it 'should charge 1 when a journey is complete' do
        expect(subject.fare).to eq 1
      end
    end

    context 'penalty fares' do
      let(:subject) { described_class.new(entry_station) }
      it 'should charge penalty fare if no exit station' do
        expect(subject.fare).to eq 6
      end
    end
  end

  describe '#in_journey' do
    let(:subject) { described_class.new(entry_station) }
    it "should report that it's in a journey" do
      expect(subject.in_journey).to eq true
    end
    context 'not in journey' do
      let(:subject) { described_class.new }
      it 'when instantiated' do
        expect(subject.in_journey).to eq false
      end

      let(:subject) { described_class.new(entry_station, exit_station) }
      it 'when touched in and then touched out' do
        expect(subject.in_journey).to eq false
      end
    end
  end
end
