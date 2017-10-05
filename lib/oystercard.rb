require_relative 'Journey'
class Oystercard
  attr_reader :balance, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Card limit #{MAXIMUM_BALANCE} exceeded!" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(entry_station)
    touching_in_errors
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @current_journey.end_journey(exit_station)
    deduct(@current_journey.fare)
    add_journey
  end

  def entry_station
    !!@current_journey ? @current_journey.entry_station : nil
  end

  def exit_station
    !!@journeys ? @journeys.last.exit_station : nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey
    @journeys << @current_journey
    @current_journey = nil
  end

  def touching_in_errors
    raise "Card balance below minimum of #{Oystercard::MINIMUM_CHARGE}!" if @balance < MINIMUM_CHARGE
    deduct(PENALTY_FARE) if entry_station
  end
end
