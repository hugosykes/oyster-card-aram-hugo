require 'oystercard'
class Journey
  def initialize(oystercard)
    @oystercard = oystercard
    card.journeys << { entry_station: nil, exit_station: nil }
  end

  def touch_in(entry_station)
    raise "Can't travel without minimum balance!" if card.balance < Oystercard::MINIMUM_CHARGE
    @entry_station = entry_station
    card.deduct(Oystercard::PENALTY_FARE)
    card.last_journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    card.deduct(Oystercard::PENALTY_FARE) unless in_journey?
    card.top_up(Oystercard::PENALTY_FARE - fare) if in_journey?
    card.last_journey[:exit_station] = exit_station
  end

  def in_journey?
    !!@entry_station
  end

  private

  def card
    @oystercard
  end

  def fare
    1
  end
end
