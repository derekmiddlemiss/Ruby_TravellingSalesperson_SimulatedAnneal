class Trip

  attr_reader :cities, :constraints, :travel, :old_travel, :best_cities, :best_travel

  def initialize(options)
    @cities = options[:cities] ? options[:cities] : []
    @constraints = options[:constraints] ? options[:constraints] : []
    @old_cities = []
    @best_cities = []
    @travel = 0
    @old_travel = 0
    @best_travel = Float::MAX
    @fix_start = options[:fix_start] ? options[:fix_start] : false
    if options[:cities] || options[:constraints]
      calc_travel()
      @best_travel = @travel
    end
  end

  def add_city(city)
    @cities.push(city)
    calc_travel()
    @best_travel = @travel
  end

  def delete_city(city)
    @cities.delete(city)
    calc_travel()
    @best_travel = @travel
  end

  def add_constraint(constraint)
    @constraints.push(constraint)
    calc_travel()
    @best_travel = @travel
  end

  def delete_constraint(constraint)
    @constraints.delete(constraint)
    calc_travel()
    @best_travel = @travel
  end

  def number_of_cities
    return @cities.length
  end

  def shuffle
    @old_cities.replace(@cities)
    @old_travel = @travel
    if @fix_start
      @cities[1..-1] = @cities[1..-1].shuffle()
    else
      @cities.shuffle!()
    end
    calc_travel()
  end

  def flip
    @old_cities.replace(@cities)
    @old_travel = @travel
    if @fix_start
      index_pool = Range.new(1, number_of_cities - 1).to_a
    else
      index_pool = Range.new(0, number_of_cities - 1).to_a
    end
    index1 = index_pool.sample
    index_pool.delete(index1)
    index2 = index_pool.sample
    @cities[index1], @cities[index2] = @cities[index2], @cities[index1]
    calc_travel()
  end

  def revert
    @cities.replace(@old_cities)
    @travel = @old_travel
  end

  def calc_travel
    @travel = 0.0
    shifted = @cities.rotate(1)
    @cities.zip(shifted).each { |city_pair|
      @travel += city_pair[0].distance_from(city_pair[1])
    }
    @constraints.each do |constraint|
      @travel += constraint.penalty(@cities)
    end
    if @travel < @best_travel
      @best_cities.replace(@cities)
      @best_travel = @travel
    end
  end

  def set_best
    @cities.replace(@best_cities)
    @travel = @best_travel
  end

  def to_s
    string = "*Travel*: #{"%.3f" % @travel} *Itinerary*: ("
    for city in @cities
      string += city.to_s + " -> "
    end
    string += @cities.first.to_s + ") *Constraints*: "
    string += "FixStart, " if @fix_start
    for constraint in @constraints
      string += constraint.to_s(@cities) + ", "
    end
    return string
  end

end
