require_relative 'oystercard'
class Journey
  attr_reader :entry_station, :exit_station, :journey_balance

  def initialize(oystercard)
    @oystercard = oystercard
    card.journeys << { entry_station: nil, exit_station: nil }
    @balance = -Oystercard::PENALTY_FARE
  end

  def touch_in(entry_station)
    raise "Can't travel without minimum balance!" if card.balance < Oystercard::MINIMUM_CHARGE
    @entry_station = entry_station
    calc_and_set
    # card.deduct(Oystercard::PENALTY_FARE)
    # card.last_journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    calc_and_set
    # card.deduct(Oystercard::PENALTY_FARE) unless in_journey?
    # card.top_up(Oystercard::PENALTY_FARE - fare) if in_journey?
    # card.last_journey[:exit_station] = exit_station
  end

  def calc_and_set
    calculate_fare #(@entry_station, @exit_station)
    card.set_journey(self)
  end

  def journey_balance
    @balance
  end

  private

  def card
    @oystercard
  end

  # def fare
  #   1
  # end

  def calculate_fare
    @balance = -Oystercard::PENALTY_FARE if !(@entry_station && @exit_station)
    @balance = Oystercard::PENALTY_FARE - Oystercard::MINIMUM_CHARGE if (@entry_station && @exit_station)
  end
end
