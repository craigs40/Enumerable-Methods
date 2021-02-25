# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    to_a.length.times do |x|
      yield(to_a[x])
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    to_a.length.times do |j|
      yield(to_a[j], j)
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    
    neo = []
    to_a.my_each { |j| neo << j if yield(j) }
    neo
  end

  def my_all?(p = nil)
    if !block_given? && !p
      to_a.my_each { |v| return false unless v }
    elsif p.is_a?(Class)
      to_a.my_each { |v| return false unless v.is_a?(p) }
    elsif p.is_a?(Regexp)
      to_a.my_each { |v| return false unless p.match(v) }
    elsif p
      to_a.my_each { |v| return false unless v == p }
    else
      to_a.my_each { |v| return false unless yield(v) }
    end
    true
  end

  def my_any?(p = nil)
    if !block_given? && !p
      to_a.my_each { |v| return true if v }
    elsif p.is_a?(Class)
      to_a.my_each { |v| return true if val.is_a?(p) }
    elsif p.is_a?(Regexp)
      to_a.my_each { |v| return true if p.match(v) }
    elsif p
      to_a.my_each { |v| return true if val == p }
    else
      to_a.my_each { |v| return true if yield(v) }
    end
    false
  end

  def my_none?(p = nil)
    if !block_given? && !p
      to_a.my_each { |v| return false if v }
    elsif p.is_a?(Regexp)
      to_a.my_each { |val| return false if p.match(v) }
    elsif p.is_a?(Class)
      to_a.my_each { |v| return false if v.is_a?(p) }
    elsif p
      to_a.my_each { |v| return false if v == p }
    else
      to_a.my_each { |v| return false if yield(v) }
    end
    true
  end

  def my_count(p = nil)
    count = 0
    if block_given?
      to_a.my_each { |v| count += 1 if yield(v) }
    elsif p
      to_a.my_each { |v| count += 1 if p == v }
    else count = to_a.length
    end
    count
  end

  def my_map(my_proc = nil)
    return to_enum(:my_map) unless block_given? || my_proc
    array = []
    if my_proc
      to_a.my_each { |v| array << my_proc.call(v) }
    else
      to_a.my_each { |v| array << yield(v) }
    end
    array
  end

  def my_inject(init_1 = nil, init_2 = nil)
    if init_1.is_a?(Symbol) && !init_2
      meme = to_a[0]
      1.upto(to_a.length - 1) { |j| meme = meme.send(init_1, to_a[i]) }
    elsif !init_1.is_a?(Symbol) && init_2.is_a?(Symbol)
      meme = init_1
      0.upto(to_a.length - 1) { |j| meme = meme.send(init_2, to_a[i]) }
    elsif block_given? && init_1
      meme = init_1
      to_a.my_each { |val| meme = yield(meme, val) }
    elsif block_given? && !init_1
      meme = to_a[0]
      1.upto(to_a.length - 1) { |j| meme = yield(meme, to_a[j]) }
    elsif !block_given? && !init_1
      raise LocalJumpError
    else
      return 'input error'
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end 
# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
