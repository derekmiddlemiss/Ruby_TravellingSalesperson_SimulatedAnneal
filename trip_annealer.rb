require('pry')

class TripAnnealer

  attr_accessor :trip, :initial_temp, :final_temp, :alpha, :moves_per_temp

  def initialize(options)
    @trip = options[:trip]
    @initial_temp = options[:initial_temp] ? options[:initial_temp] : 1000.0
    @final_temp = options[:final_temp] ? options[:final_temp] : 1.0
    @alpha = options[:alpha] ? options[:alpha] : 0.95
    @moves_per_temp = options[:moves_per_temp] ? options[:moves_per_temp] : 1000
    @debug = options[:debug] ? options[:debug] : false
  end

  def anneal
    @temp = @initial_temp
    @trip.shuffle()
    puts "Temp: #{@temp} Starting trip: " + @trip.to_s
    while @temp > @final_temp
      @moves = 0
      @accept = 0
      while @moves < @moves_per_temp
        make_move()
      end
      log_progress() if @debug
      @temp *= @alpha
    end
    @trip.set_best()
    puts "Temp: #{@temp} Final trip: " + @trip.to_s
  end

  def make_move
    @trip.flip()
    @moves += 1
    @accept += 1
    if (@trip.travel > @trip.old_travel) && (rand() > accept_prob)
      @trip.revert()
      @accept -= 1
    end

  end

  def log_progress
    accept_percent_string = "%.3f" % (@accept * 100.0 / @moves_per_temp)
    puts "Temperature: " + "%.3f" % @temp + ", accept %: " + accept_percent_string
  end

  def accept_prob
    return Math.exp( -1.0 * (@trip.travel - @trip.old_travel) / @temp )
  end

end
