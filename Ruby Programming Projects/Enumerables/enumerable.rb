module Enumerable
  def my_each
    return unless block_given?

    for value in self
      yield value
    end
    self
  end

  def my_each_with_index
    return unless block_given?

    i = 0
    self.my_each do |value|
      print "#{i}: "
      yield value
      i += 1
    end
    self
  end

  def my_select
    return unless block_given?

    answer = []
    self.my_each do |x|
      if yield x
        answer << x
      end
    end
    answer
  end

  def my_all
    return unless block_given?

    self.my_each do |value|
      if not yield value
        return false
      end
    end
    return true
  end

  def my_any
    return unless block_given?

    self.my_each do |value|
      if yield value
        return true
      end
    end
    return false
  end

  def my_none
    return unless block_given?

    self.my_each do |value|
      if yield value
        return false
      end
    end
    return true
  end

  def my_count object = nil
    count = 0
    if block_given?
      self.my_each {|value| count += 1 if yield value}
    elsif object
      self.my_each {|value| count += 1 if value == object}
    else
      count = self.length
    end
    count
  end

  def my_map
    return self unless block_given?

    mappedArray = Array.new
    self.my_each do |value|
      mappedArray.push yield value
    end
    mappedArray
  end

  def my_inject result = nil
    return unless block_given?

    result = self[0] if not result
    self.my_each do |value|
      result = yield result, value
    end
    result
  end

  def my_map_proc proc

    mappedArray = Array.new
    self.my_each do |value|
      mappedArray.push proc.call value
    end
    mappedArray
  end

  def my_map_proc_and_block proc
    return self unless proc and block_given?

    mappedArray = Array.new
    self.my_each do |value|
      var = proc.call value
      mappedArray.push yield var
    end
    mappedArray
  end
end
