require_relative 'Journey'
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
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def last_journey
    @journeys.last unless @journeys.empty?
  end
end
