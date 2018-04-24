# Implements a basic FIFO queue using two stacks
class QueueOfTwoStacks
  attr_reader :inbound
  def initialize(items = [])
    @inbound = items
    @outbound = []
  end

  def enqueue(item)
    @inbound << item
  end

  def dequeue
    outbound.pop
  end

  def print_first
    puts outbound.last
  end

  def outbound
    maintain_invariant
    @outbound
  end

  private def maintain_invariant
    return unless @outbound.empty?
    @outbound = @inbound.reverse
    @inbound = []
    nil
  end
end
