# Finds the nearest repeated entries in an Array
class NearestRepeatedEntriesFinder
  attr_reader :nearest_indices
  def initialize
    @entry_indices = {}
    @nearest_indices = []
  end

  def add(entry, index)
    @entry_indices[entry] ||= []
    @entry_indices[entry] << index
    update_nearest entry
    entry
  end

  # Returns a 2-tuple containing the 0 based indices of the input array
  # containing the nearest repeated entries
  def self.find(entries = [])
    finder = NearestRepeatedEntriesFinder.new
    entries.each_with_index do |entry, idx|
      finder.add entry, idx
    end
    finder.nearest_indices
  end

  private

  def update_nearest(latest_entry)
    return unless repeated? latest_entry
    (idx_a, idx_b) = @entry_indices[latest_entry].last(2)
    @nearest_indices = [idx_a, idx_b] if closest? idx_a, idx_b
    nil
  end

  def repeated?(entry)
    @entry_indices.key?(entry) && @entry_indices[entry].length >= 2
  end

  def closest?(idx_a, idx_b)
    return true if @nearest_indices.length.zero?
    (idx_a - idx_b).abs < (@nearest_indices[0] - @nearest_indices[1]).abs
  end
end
