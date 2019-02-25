require('minitest/autorun')
require('minitest/rg')
require_relative('../constraint')
require_relative('../city')

class ConstraintTest < MiniTest::Test

  def setup
    @city = City.new(name: 'Prague', xcoord: 10.0, ycoord: 45.0)
    @other_city = City.new(name: 'London', xcoord: 5.0, ycoord: 30.0)
    @yet_another_city = City.new(name: 'Tokyo', xcoord: 30.0, ycoord: 10.0)
    @constraint = Constraint.new(first: @city, last: @other_city, weight: 50.0)
  end

  def test_incomplete_spec_raises_runtime_error__no_first_city
    assert_raises RuntimeError do
      Constraint.new(last: @other_city, weight: 50.0)
    end
  end

  def test_incomplete_spec_raises_runtime_error__no_last_city
    assert_raises RuntimeError do
      Constraint.new(first: @city, weight: 50.0)
    end
  end

  def test_incomplete_spec_raises_runtime_error__no_weight
    assert_raises RuntimeError do
      Constraint.new(first: @city, last: @other_city)
    end
  end

  def test_populate__cities_in_spec_right_order
    @constraint.populate(@city)
    @constraint.populate(@other_city)
    assert_equal()

  end
end
