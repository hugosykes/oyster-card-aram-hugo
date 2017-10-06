require 'Journey'
describe Journey do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:subject) { described_class.new(Oystercard.new) }

  describe '#touch_in' do
    context 'card has no balance' do
      it 'prevents travel if card is below minimum balance' do
        expect { subject.touch_in(entry_station) }.to raise_error "Can't travel without minimum balance!"
      end
    end

    context 'card has minimum balance' do
      let(:oystercard) { Oystercard.new }
      before { oystercard.top_up(Oystercard::MINIMUM_CHARGE) }
      let(:subject) { described_class.new(oystercard) }
      it 'notes the entry station' do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
    end
  end

  describe '#touch_out' do

  end

end
