class Station
  attr_reader :name, :zone

  def initialize
    @name = ''
    @zone = (1..6).to_a.sample
  end
end
