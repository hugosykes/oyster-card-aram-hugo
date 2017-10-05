class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def in_journey
    !!@entry_station && !@exit_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    return 6 unless @exit_station
    1
  end
end
