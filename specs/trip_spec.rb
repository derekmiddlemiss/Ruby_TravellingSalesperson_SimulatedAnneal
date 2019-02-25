require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../trip')
require_relative('../city')

class TripTest < MiniTest::Test

  def setup
    @trip = Trip.new({})
    @city1 = City.new(name: 'Prague', xcoord: 10.0, ycoord: 0.0)
    @city2 = City.new(name: 'London', xcoord: 20.0, ycoord: 0.0)
    @city3 = City.new(name: 'Cairo', xcoord: 30.0, ycoord: 0.0)
  end

  def test_new_trip_has_empty_cities
    assert_equal(0, @trip.number_of_cities)
  end

  def test_trip_can_add_city
    @trip.add_city(@city1)
    assert_equal(1, @trip.number_of_cities)
  end

  def test_travel__zero_for_no_cities
    assert_in_delta(0.0, @trip.travel, 1E-6 )
  end

  def test_travel__zero_for_one_city
    @trip.add_city(@city1)
    assert_in_delta(0.0, @trip.travel, 1E-6 )
  end

  def test_travel__two_cities
    @trip.add_city(@city1)
    @trip.add_city(@city2)
    assert_in_delta(20.0, @trip.travel, 1E-6)
  end

  def test_travel__two_cities_opp_order
    @trip.add_city(@city2)
    @trip.add_city(@city1)
    assert_in_delta(20.0, @trip.travel, 1E-6)
  end

  def test_travel__three_cities
    @trip.add_city(@city1)
    @trip.add_city(@city2)
    @trip.add_city(@city3)
    assert_in_delta(40.0, @trip.travel, 1E-6)
  end

  def test_travel__three_cities_rotated
    @trip.add_city(@city2)
    @trip.add_city(@city1)
    @trip.add_city(@city3)
    assert_in_delta(40.0, @trip.travel, 1E-6)
  end

  def test_shuffle__smelly
    @trip.add_city(@city1)
    @trip.add_city(@city2)
    @trip.add_city(@city3)
    original = []
    shuffled = []
    original.replace(@trip.cities)
    loop do
      @trip.shuffle
      shuffled.replace(@trip.cities)
      break if !shuffled.eql?(original)
    end
    assert(true)
  end

  def test_flip__smelly
    @trip.add_city(@city1)
    @trip.add_city(@city2)
    @trip.add_city(@city3)
    original = []
    flipped = []
    original.replace(@trip.cities)
    loop do
      @trip.flip
      flipped.replace(@trip.cities)
      break if !flipped.eql?(original)
    end
    assert(true)
  end


end
