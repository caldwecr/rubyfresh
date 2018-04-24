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

  def read_first
    outbound.last
  end

  def outbound
    maintain_invariant
    @outbound
  end

  def self.process_input(input)
    output = []
    queries = input.drop 1 # Remove the number of queries from the input
    queue = QueueOfTwoStacks.new
    queries.each do |query|
      query_parts = query.split
      query_type = query_parts.first
      case query_type
      when '1'
        queue.enqueue query_parts[1]
      when '2'
        queue.dequeue
      when '3'
        output << queue.read_first
      else
        raise ArgumentError, 'Unrecognized query type.'
      end
    end
    output
  end

  private def maintain_invariant
    return unless @outbound.empty?
    @outbound = @inbound.reverse
    @inbound = []
    nil
  end
end

input = $stdin.readlines
QueueOfTwoStacks.process_input(input).each do |output|
  puts output
end
