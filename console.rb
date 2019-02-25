require_relative('city')
require_relative('trip')
require_relative('trip_annealer')
require_relative('binary_constraint')

city1 = City.new(name: 'Prague', xcoord: 0.0, ycoord: 0.0)
city2 = City.new(name: 'London', xcoord: 10.0, ycoord: 0.0)
city3 = City.new(name: 'Madrid', xcoord: 10.0, ycoord: 10.0)
city4 = City.new(name: 'Istanbul', xcoord: 0.0, ycoord: 10.0)
city5 = City.new(name: 'Kolkata', xcoord: 60.0, ycoord: 12.0)
city6 = City.new(name: 'Beijing', xcoord: 70.0, ycoord: -10.0)
city7 = City.new(name: 'Sydney', xcoord: 200.0, ycoord: -80.0)
city8 = City.new(name: 'Harare', xcoord: -20.0, ycoord: -4.0)
city9 = City.new(name: 'Kuala Lumpur', xcoord: 12.0, ycoord: -8.0)
city10 = City.new(name: 'Tokyo', xcoord: 65.0, ycoord: 7.0)
city11 = City.new(name: 'Rio de Janeiro', xcoord: -21.0, ycoord: 37.0)
city12 = City.new(name: 'New York', xcoord: -46.0, ycoord: 13.0)
city13 = City.new(name: 'Boston', xcoord: -40.0, ycoord: 10.0)
city14 = City.new(name: 'Toronto', xcoord: -130.0, ycoord: 18.0)
city15 = City.new(name: 'Caracas', xcoord: -30.0, ycoord: 45.0)
city16 = City.new(name: 'Rome', xcoord: 60.0, ycoord: -80.0)
city17 = City.new(name: 'Johannesburg', xcoord: 14.0, ycoord: -70.0)
city18 = City.new(name: 'Athens', xcoord: -70.0, ycoord: 105.0)
city19 = City.new(name: 'Moscow', xcoord: 4.0, ycoord: 80.0)
city20 = City.new(name: 'Bombay', xcoord: -94.0, ycoord: 65.0)

cities = [city1, city2, city3, city4, city5, city6,
  city7, city8, city9, city10, city11, city12,
  city13, city14, city15, city16, city17, city18, city19, city20]

Istanbul_Kuala_Lumpur_const = BinaryConstraint.new(start: city4, end: city9, weight: 200.0)
Madrid_Rio_de_Janeiro_const = BinaryConstraint.new(start: city3, end: city11, weight: 200.0)
New_York_Istanbul_const = BinaryConstraint.new(start: city12, end: city4, weight: 200.0 )
constraints = [Istanbul_Kuala_Lumpur_const, Madrid_Rio_de_Janeiro_const, New_York_Istanbul_const]
# constraints = []

# trip = Trip.new(cities: cities, fix_start: true)
trip = Trip.new(cities: cities, constraints: constraints, fix_start: true)

trip_annealer = TripAnnealer.new(
  trip: trip,
  initial_temp: 6000,
  final_temp: 0.05,
  alpha: 0.95,
  moves_per_temp: 20000,
  debug: true)
trip_annealer.anneal()
