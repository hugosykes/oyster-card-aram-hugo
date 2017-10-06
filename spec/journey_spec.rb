require 'Journey'
describe Journey do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:oystercard) { Oystercard.new }
  before { oystercard.top_up(Oystercard::MINIMUM_CHARGE) }
  let(:subject) { described_class.new(oystercard) }

  describe '#touch_in' do
    context 'card has no balance' do
      let(:subject) { described_class.new(Oystercard.new) }
      it 'prevents travel if card is below minimum balance' do
        expect { subject.touch_in(entry_station) }.to raise_error "Can't travel without minimum balance!"
      end
    end

    context 'card has minimum balance' do
      it 'notes the entry station' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq(entry_station)
      end
    end
  end

  describe '#touch_out' do
    it 'notes the exit station' do
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    context 'touched in' do
      before { subject.touch_in(entry_station) }
      it 'should reimburse oyster card by the difference between penalty and minimum fare' do
        expect { subject.touch_out(exit_station) }.to change { oystercard.balance }.by(Oystercard::PENALTY_FARE - 1)
      end
    end
  end

  describe '#calc_and_set' do


  end
end
