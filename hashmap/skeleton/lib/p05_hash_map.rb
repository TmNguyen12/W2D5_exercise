require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val) # []=


    if include?(key)
      bucket(key).update(key,val)  #update is a function on the link list and not the node
    else
      if count >= num_buckets - 1
        @count = 0
        resize!
      end
      bucket(key).append(key, val)
      @count += 1

    end
    nil
  end

  # def count
  #
  # end

  def get(key) #[]
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    # debugger
    @store.each do |link_list|
      link_list.each do |node|
        prc.call(node.key, node.val)
      end
    end

  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store
    old_size = num_buckets
    @store = Array.new(old_size * 2) {LinkedList.new}
    temp_store.each do |bucket|
      bucket.each do |node|
        set(node.key, node.val)
      end
    end
  end




  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
