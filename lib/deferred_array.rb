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
  attr_reader :array_size, :ops

  def initialize(array_size, ops)
    @array_size = array_size
    @ops = ops
  end

  def [](idx)
    val = 0
    ops.each do |op|
      val += op[2] if op_spans_idx? op, idx
    end
    val
  end

  private

  def op_spans_idx?(op, idx)
    op[0] <= idx && op[1] >= idx
  end
end