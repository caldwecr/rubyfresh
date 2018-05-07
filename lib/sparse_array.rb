# Data Structure for HackerRank's challenge called SparseArrays
# internally we use a hash to track the number of occurrences of
# each value
class SparseArray
  attr_reader :store
  def initialize
    @store = {}
  end

  def append(val)
    @store[val] ||= 0
    @store[val] += 1
  end

  def num_occurrences(val)
    @store[val] || 0
  end

  def self.process_input(input)
    outputs = []
    num_of_strings = input.first.to_i
    strings = input[1..num_of_strings].map(&:strip)
    throw ArgumentError unless num_of_strings == strings.count
    num_of_queries = input[num_of_strings + 1].to_i
    queries = input[(num_of_strings + 2)..-1].map(&:strip)
    throw ArgumentError unless num_of_queries == queries.count

    sparse_array = new
    strings.each do |str|
      sparse_array.append str
    end
    queries.each do |query|
      val = sparse_array.num_occurrences(query)
      outputs << val
    end
    outputs
  end
end
