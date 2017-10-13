class MaxIntSet

  def initialize(max)
    @store = Array.new(max,false)
    nil
  end

  def insert(el)
    raise "Out of bounds" if !el.between?(0,@store.length-1)
    @store[el] = true
  end

  def remove(el)
    raise "Out of bounds" if !el.between?(0,@store.length-1)
    @store[el] = false
  end

  def include?(el)
    raise "Out of bounds" if !el.between?(0,@store.length-1)
    @store[el]
  end

end
#
# a = MaxIntSet.new(10)
# p a.insert(5)
# p a.remove(6)
# p a.include?(5)
# p a.remove(11)

class IntSet

  def initialize(size = 20)
    @size = size
    @store = Array.new(size) { [] }
    nil
  end

  def count
    counter = 0
    @store.each do |bucket|
      counter += bucket.length
    end
    counter
  end

  def insert(el)
    raise "already in set" if self[el].include?(el)
    self[el] << el
    el
  end

  def remove(el)
    self[el].delete(el)
    nil
  end

  def include?(el)
    self[el].include?(el)
  end

  private

  def [](el)
    @store[el % @size]
  end
end

# a = IntSet.new(10)
# p a.insert(10000000)
# p a.remove(-20)
# p a.include?(-20)
# p a.insert(11)
# p a.insert(10000000)

class ResizingIntSet < IntSet
  def insert(el)
    if count >= @size
      temp_store = @store
      @size *= 2
      @store = Array.new(@size) { [] }
      temp_store.each do |bucket|
        bucket.each do |el2|
          super(el2)
        end
      end
    end

    super(el)
  end

  def what_size
    @size
  end

end


# ris = ResizingIntSet.new(2)
#
# (0..32).each do |num|
#   ris.insert(num)
#   puts "try #{num}: size = #{ris.what_size}"
# end














#
