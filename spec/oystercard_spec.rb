require './lib/oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'expects oystercard to be initialized with an empty array' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#balance' do
    it 'check a new card has a balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allow a card to be topped up' do
      val = rand(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up val }.to change { subject.balance }.by val
    end

    it 'throws exception if top-up limit is exceeded' do
      expect { subject.top_up Oystercard::MAXIMUM_BALANCE + 1 }.to raise_error "Card limit #{Oystercard::MAXIMUM_BALANCE} exceeded!"
    end
  end

  describe '#deduct' do
    before { subject.top_up Oystercard::MAXIMUM_BALANCE }
    it 'should deduct money from the card' do
      val = rand(Oystercard::MAXIMUM_BALANCE)
      expect { subject.deduct val }.to change { subject.balance }.by(-val)
    end
  end

  describe '#last_journey' do
    it 'should return nil if journeys array is empty' do
      expect(subject.last_journey).to be_nil
    end

    let(:journey) { double(:journey) }
    it 'should return last object in the journeys array' do
      subject.journeys << journey
      expect(subject.last_journey).to eq journey
    end
  end
end
