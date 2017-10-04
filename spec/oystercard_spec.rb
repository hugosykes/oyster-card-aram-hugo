require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'check a new card has a balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allow a card to be topped up' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

    it 'throws exception if top-up limit is exceeded' do
      expect { oystercard.top_up Oystercard::MAXIMUM_BALANCE + 1 }.to raise_error "Card limit #{Oystercard::MAXIMUM_BALANCE} exceeded!"
    end
  end

  describe '#in_journey' do
    it 'returns status' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    let(:station) {double(:station)}
    it 'updates in_journey to true' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'only allows touch in if the card has a minimum balance' do
      expect { oystercard.touch_in(station) }.to raise_error "Card balance below minimum of #{Oystercard::MINIMUM_BALANCE}!"
    end

    it 'notes the entry station of a journey' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    let(:station) {double(:station)}
    it 'updates in_journey to false' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the minimum fare' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect { oystercard.touch_out }.to change {oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'resets entry_station to nil when touching out' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect { oystercard.touch_out }.to change { oystercard.entry_station }.from(station).to(nil)
    end
  end


end
