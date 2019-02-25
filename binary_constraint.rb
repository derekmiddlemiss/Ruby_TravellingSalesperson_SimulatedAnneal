class BinaryConstraint

  def initialize(options)
    if !(options[:start] && options[:end] && options[:weight])
      raise RuntimeError.new("BinaryConstraint: not fully specified")
    end
    if (options[:start] == options[:end])
      raise RuntimeError.new("BinaryConstraint: no travel")
    end
    @start = options[:start]
    @end = options[:end]
    @weight = options[:weight].to_f
  end

  def penalty(cities)
    start_index = cities.index(@start)
    end_index = cities.index(@end)
    if @end == cities.first()
      end_index = cities.length()
    end
    return start_index < end_index ? 0.0 : @weight
  end

  def to_s(cities)
    return "BinaryConstraint(#{@start} then #{@end}, curr. penalty: #{penalty(cities)})"
  end

end
