class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_total = 0
    each_with_index do |el, idx|
      hash_total += (el.hash + idx).hash
    end
    hash_total.hash
  end
end

class String
  def hash
    arr = self.chars.map(&:ord)
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    kv_arr = to_a
    kv_arr.sort_by! { |kv| kv[0] }
    kv_arr.hash
  end
end
