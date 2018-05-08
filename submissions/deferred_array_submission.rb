# A special Array type that accepts range operations that update values
# within the specified range. Designed to solve for the requirements
# of Hackerrank's Array Manipulation problem
class DeferredArray
  # Represents a span of natural number indices and a val belonging to each
  # idx in the span's range
  class Span
    attr_reader :start_idx, :end_idx, :val
    def initialize(start_idx, end_idx, val)
      @start_idx = start_idx
      @end_idx = end_idx
      @val = val
    end

    def overlaps?(other)
      (start_idx >= other.start_idx && start_idx <= other.end_idx) ||
          (end_idx >= other.start_idx && end_idx <= other.end_idx) ||
          covers?(other)
    end

    def covers?(other)
      covers_start?(other) && covers_end?(other)
    end

    def covers_idx?(idx)
      start_idx <= idx && end_idx >= idx
    end

    def covers_start?(other)
      start_idx <= other.start_idx && end_idx >= other.start_idx
    end

    def covers_end?(other)
      start_idx <= other.end_idx && end_idx >= other.end_idx
    end

    def ==(other)
      self.class == other.class &&
          start_idx == other.start_idx &&
          end_idx == other.end_idx &&
          val == other.val
    end

    def self.combine(left, right)
      return [left, right].sort_by(&:start_idx) unless left.overlaps? right
      # handle the case where left covers right
      if left.covers? right
        if left.start_idx == right.start_idx
          if left.end_idx == right.end_idx
            return [Span.new(left.start_idx, left.end_idx, left.val + right.val)]
          else
            return [Span.new(left.start_idx, right.end_idx, left.val + right.val),
                    Span.new(right.end_idx + 1, left.end_idx, left.val)]
          end
        else
          if left.end_idx == right.end_idx
            return [Span.new(left.start_idx, right.start_idx - 1, left.val),
                    Span.new(right.start_idx, right.end_idx, right.val + left.val)]
          else
            return [Span.new(left.start_idx, right.start_idx - 1, left.val),
                    Span.new(right.start_idx, right.end_idx, left.val + right.val),
                    Span.new(right.end_idx + 1, left.end_idx, left.val)]
          end
        end
        # handle the case where right covers left, but left does not cover right
      elsif right.covers?(left)
        return combine(right, left)
        # handle the case where left covers the start of right, but not the end of right
      elsif left.covers_start? right
        if left.start_idx == right.start_idx
          return [Span.new(left.start_idx, left.end_idx, left.val + right.val),
                  Span.new(left.end_idx + 1, right.end_idx, right.val)]
        else
          return [Span.new(left.start_idx, right.start_idx - 1, left.val),
                  Span.new(right.start_idx, left.end_idx, left.val + right.val),
                  Span.new(left.end_idx + 1, right.end_idx, right.val)]
        end
        # handle the case where left covers the end of right, but not the start of right
      elsif left.covers_end? right
        return combine(right, left)
      else
        throw ArgumentError
      end
    end
  end
  attr_reader :array_size, :spans

  def initialize(array_size)
    @array_size = array_size
    @spans = []
  end

  def max
    spans.map(&:val).max
  end

  def add_span(span)
    partitioned = partition_spans span

    new_spans = [span] if partitioned[:impacted].empty?
    new_spans ||= partitioned[:impacted].map { |impacted_span| Span.combine impacted_span, span }.flatten
    @spans = partitioned[:left]
                 .concat(new_spans)
                 .concat(partitioned[:right])
  end

  def [](idx)
    spans.each do |span|
      return span.val if span.covers_idx? idx
    end
    0
  end

  # Returns three arrays left spans, impacted spans, and right spans
  def partition_spans(span)
    left_spans = []
    impacted_spans = []
    right_spans = []
    spans.each do |curr_span|
      if curr_span.overlaps? span
        impacted_spans << curr_span
      elsif curr_span.start_idx < span.start_idx
        left_spans << curr_span
      else
        right_spans << curr_span
      end
    end
    { left: left_spans, impacted: impacted_spans, right: right_spans }
  end
end
input = $stdin.readlines
array_length = input.shift.split(' ').first
da = DeferredArray.new(array_length)
input.each do |line|
  split_line = line.strip.split(' ').map(&:to_i)
  da.add_span DeferredArray::Span.new(split_line[0] - 1, split_line[1] - 1, split_line[2])
end
puts da.max