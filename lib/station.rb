class Station
  attr_reader :name, :zone

  def initialize
    @name = ''
    @zone = rand(6)
  end
end
