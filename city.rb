class City

  attr_reader :name, :xcoord, :ycoord

  def initialize(options)
    @name = options[:name]
    @xcoord = options[:xcoord]
    @ycoord = options[:ycoord]
  end

  def distance_from(city)
    x_diff = @xcoord - city.xcoord
    y_diff = @ycoord - city.ycoord
    return Math.sqrt(x_diff**2 + y_diff**2)
  end

  def to_s
    return "#{@name}"
  end

end
