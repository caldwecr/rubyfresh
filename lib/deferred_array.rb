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

    def inspect
      { start_idx: start_idx, end_idx: end_idx, val: val }.to_s
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
      unless left.overlaps? right
        val = if left.start_idx <= right.start_idx
                [nil, left, right]
              else
                [right, left, nil]
              end
        return val
      end
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

  # A special binary tree for spans
  # Currently it will be right heavy proportional to the number of duples that are returned from combine
  class SpanNode
    attr_reader :span, :left, :right, :max_value, :default_value

    def initialize(initialization_value = 0)
      @default_value = initialization_value
    end

    def inspect
      # this other variant of inspect is helpful when debugging rspec test issues
      # to_arr.to_s
      { span: span, left: left, right: right, max_value: max_value, default_value: default_value }.to_s
    end

    def ==(other)
      return other == to_arr if other.is_a? Array

      self.class == other.class &&
        span == other.span &&
        left == other.left &&
        right == other.right &&
        max_value == other.max_value &&
        default_value == other.default_value
    end

    def to_arr
      left_arr = [] if left.nil?
      left_arr ||= left.to_arr
      right_arr = [] if right.nil?
      right_arr ||= right.to_arr
      left_arr.concat([span]).concat(right_arr)
    end

    def push(new_span)
      # Remember that the span can span between any or none of self.span, left.span, and right.span
      # Case 0: new_span is nil
      return new_span if new_span.nil?
      # Case 1: span is nil
      if span.nil?
        @span = new_span
        @max_value = span.val
        return span
      end
      # Case 2: span is not nil
      spans = Span.combine span, new_span
      if spans.count == 1
        @span = spans[0]
      elsif spans.count == 2
        @span = spans[0]
        @right ||= SpanNode.new
        right.push spans[1]
      else # spans.count == 3
        if spans[0]
          @left ||= SpanNode.new
          left.push spans[0]
        end
        @span = spans[1]
        if spans[2]
          @right ||= SpanNode.new
          right.push spans[2]
        end
      end
      update_max
      span
    end

    def update_max
      maxs = []
      maxs << left.max_value unless left.nil?
      maxs << max_value
      maxs << span.val
      maxs << right.max_value unless right.nil?
      @max_value = maxs.max
    end

    def [](idx)
      return 0 if span.nil?
      return span.val if idx >= span.start_idx && idx <= span.end_idx
      if idx < span.start_idx
        return 0 if left.nil?
        left[idx]
      elsif idx > span.end_idx
        return 0 if right.nil?
        right[idx]
      end
    end
  end
  attr_reader :array_size, :spans

  def initialize(array_size)
    @array_size = array_size
    @spans = SpanNode.new
  end

  def max
    spans.max_value
  end

  def add_span(span)
    spans.push span
  end

  def [](idx)
    spans[idx]
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
