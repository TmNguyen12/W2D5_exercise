class Node
  attr_accessor :key, :val, :prev, :next

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @prev = nil
    @next = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects nextious link to prev link
    # and removes self from list.
    return false if @prev == nil || @next == nil
    @prev.next = @next
    @next.prev = @prev
    @val
  end
end





class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.equal?(@tail)  #simple identity comparison (pointer equality )
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    old_last = last

    @tail.prev = new_node
    old_last.next = new_node
    new_node.prev = old_last
    new_node.next = @tail

  end

  def update(key, val)
    each { |link| return link.val = val if link.key == key }
  end

  def remove(key)
    each { |link| return link.remove if link.key == key }

  end

  def each(&prc)
    current_node = @head.next
    until current_node.equal?(@tail)
      prc.call(current_node)
      current_node = current_node.next
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
