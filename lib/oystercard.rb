class Oystercard
  attr_reader :balance, :entry_station, :journeys, :exit_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Card limit #{MAXIMUM_BALANCE} exceeded!" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail "Card balance below minimum of #{Oystercard::MINIMUM_BALANCE}!" if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    add_journey
    forget_entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def forget_entry_station
    @entry_station = nil
  end
end
