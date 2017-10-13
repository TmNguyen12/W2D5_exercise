require "byebug"

class MaxIntSet
  def initialize(max)
    @store = Array.new(max,false)
    nil
  end

  def insert(num)
    raise "Out of bounds" if !num.between?(0,@store.length-1)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if !num.between?(0,@store.length-1)
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if !num.between?(0,@store.length-1)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @size = num_buckets
    nil
  end

  def count
    counter = 0
    @store.each do |bucket|
      counter += bucket.length
    end
    counter
  end

  def insert(num)
    # raise "already in set" if self[num].include?(num)
    return false if self[num].include?(num)
    self[num] << num
    num
  end

  def remove(num)
    self[num].delete(num)
  nil
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @size]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet < IntSet

  def initialize(num_buckets = 20)
    # debugger
    @store = Array.new(num_buckets) { Array.new }
    @size = num_buckets
  end

  def insert(num)
    # debugger
    if count >= @size
      resize!
    end

    super(num)
  end

  def resize!
    temp_store = @store
    @size *= 2
    @store = Array.new(@size) { [] }
    temp_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

  def num_buckets
    @store.length
  end

  # def resize!
  # end
end
