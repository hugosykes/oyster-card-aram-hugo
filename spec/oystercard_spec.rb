require './lib/oystercard'

describe Oystercard do
  let(:oystercard) do
    oc = described_class.new
    oc.top_up(Oystercard::MINIMUM_BALANCE)
    oc
  end

  describe '#initialize' do
    it 'expects oystercard to be initialzed with an empty array' do
      expect(oystercard.journeys).to be_empty
    end
  end

  describe '#balance' do
    it 'check a new card has a balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allow a card to be topped up' do
      expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
    end

    it 'throws exception if top-up limit is exceeded' do
      expect { subject.top_up Oystercard::MAXIMUM_BALANCE + 1 }.to raise_error "Card limit #{Oystercard::MAXIMUM_BALANCE} exceeded!"
    end
  end

  describe '#in_journey' do
    it 'returns status' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    let(:in_station) { double(:in_station) }

    it 'updates in_journey to true' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(in_station)
      expect(oystercard).to be_in_journey
    end

    it 'only allows touch in if the card has a minimum balance' do
      expect { subject.touch_in(in_station) }.to raise_error "Card balance below minimum of #{Oystercard::MINIMUM_BALANCE}!"
    end

    it 'notes the entry station of a journey' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(in_station)
      expect(oystercard.entry_station).to eq(in_station)
    end
  end

  describe '#touch_out' do
    let(:in_station) { double(:in_station) }
    let(:out_station) { double(:out_station) }

    it 'updates in_journey to false' do
      oystercard.touch_out(out_station)
      expect(oystercard).not_to be_in_journey
    end

    context 'already in journey' do
      before do
        oystercard.touch_in(in_station)
      end

      it 'deducts the minimum fare' do
        expect { oystercard.touch_out(out_station) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_BALANCE)
      end

      it 'resets entry_station to nil when touching out' do
        expect { oystercard.touch_out(out_station) }.to change { oystercard.entry_station }.from(in_station).to(nil)
      end

      it 'notes the exit station of a journey' do
        oystercard.touch_out(out_station)
        expect(oystercard.exit_station).to eq(out_station)
      end

      it 'creates a journey from in and out stations' do
        oystercard.touch_out(out_station)
        expect(oystercard.journeys).to include(entry_station: in_station, exit_station: out_station)
      end

      it 'should raise an error if trying to touch in twice' do
        expect { oystercard.touch_in(in_station) }.to raise_error 'Already touched in!'
      end
    end
  end
end
