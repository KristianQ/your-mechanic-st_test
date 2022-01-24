class MechanicScheduler
  ALLOWED_COMMANDS = %w(add remove).freeze

  attr_reader :list

  def initialize
    reset
  end

  def reset
    @list = []
  end

  def print
    puts @list.inspect
  end

  def add(from, to)
    return @list << [from, to] if @list.size.zero?
    @list = @list.flatten.sort
    if from > @list.max
      @list = @list.each_slice(2).to_a
      @list << [from, to]
    elsif from >= @list.min && to < @list.max
      @list = @list.reject {|i| i > @list.min && i < @list.max}
      @list = @list.each_slice(2).to_a
    elsif from >= @list.min && to > @list.max
      @list = @list.reject {|i| i > @list.min}
      @list << to
      @list = @list.each_slice(2).to_a
    end
  end

  def remove(from, to)
    return false if @list.flatten.size.zero?
    return false unless from.between?(@list.flatten.min, @list.flatten.max)
    if @list.size == 1
      @list = [[@list[0][0], from], [to, @list[0][1]]] if from > @list[0][0] && to < @list[0][1]
    else
      @list = @list.flatten.reject {|value| (from..to).to_a.include?(value)}
      @list << from if from.between?(@list.flatten.min, @list.flatten.max)
      @list << to if to.between?(@list.flatten.min, @list.flatten.max)
      @list = @list.flatten.uniq.sort.each_slice(2).to_a
    end
    true
  end
end
