# Implements a basic FIFO queue using two stacks
class QueueOfTwoStacks
  attr_reader :items
  def initialize(items = [])
    @items = items
  end

  def enqueue(item)
    @items << item
  end

  def dequeue
    @items.shift
  end

  def print_first
    puts @items.first
  end
end
