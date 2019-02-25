require('minitest/autorun')
require('minitest/rg')
require_relative('../city')

class CityTest < MiniTest::Test

  def setup
    @city = City.new(name: 'Prague', xcoord: 10.0, ycoord: 45.0)
    @other_city = City.new(name: 'London', xcoord: 5.0, ycoord: 30.0)
  end

  def test_city_has_name
    assert_equal('Prague', @city.name)
  end

  def test_city_has_xcoord
    assert_in_delta(10.0, @city.xcoord, 1E-6 )
  end

  def test_city_has_ycoord
    assert_in_delta(45.0, @city.ycoord, 1E-6)
  end

  def test_city_can_calc_distance_to_other_city
    assert_in_delta(
      Math.sqrt(5.0**2 + 15.0**2),
      @city.distance_from(@other_city),
      1E-6
    )
  end

  def test_distance_same_both_ways
    assert_in_delta(
      @city.distance_from(@other_city),
      @other_city.distance_from(@city),
      1E-6
    )
  end


end
