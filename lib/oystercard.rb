# require_relative 'Journey'
class Oystercard
  attr_reader :balance, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Card limit #{MAXIMUM_BALANCE} exceeded!" if @balance + amount > MAXIMUM_BALANCE
    raise "Unable to deduct more than PENALTY_FARE #{PENALTY_FARE}" if amount < -PENALTY_FARE
    @balance += amount
  end

  # def deduct(amount)
  #   @balance -= amount
  # end
  #
  # def last_journey
  #   @journeys.last unless @journeys.empty?
  # end

  def set_journey(j)
    top_up j.journey_balance
    journeys << {j_entry: j.entry_station, j_exit:j.exit_station} if !(j.entry_station && j.exit_station)
    journeys[-1][:j_exit] = j.exit_station unless j.exit_station.nil?
  end
end
