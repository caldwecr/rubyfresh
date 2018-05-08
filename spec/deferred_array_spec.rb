require 'spec_helper'
require 'deferred_array'

describe DeferredArray::Span do
  describe '#overlaps?' do
    it 'is true when the span totally covers the other span' do
      span = DeferredArray::Span.new 0, 5, 100
      other = DeferredArray::Span.new 1, 3, 100
      expect(span.overlaps?(other)).to be true
    end

    it 'is true when the span is totally covered by the other span' do
      span = DeferredArray::Span.new 1, 3, 100
      other = DeferredArray::Span.new 0, 5, 100
      expect(span.overlaps?(other)).to be true
    end

    it "is true when the span covers the other span's start idx" do
      span = DeferredArray::Span.new 0, 2, 100
      other = DeferredArray::Span.new 1, 3, 100
      expect(span.overlaps?(other)).to be true
    end

    it "is true when the span covers the other span's end idx" do
      span = DeferredArray::Span.new 3, 5, 100
      other = DeferredArray::Span.new 1, 4, 100
      expect(span.overlaps?(other)).to be true
    end

    it 'is false when the span does not cover any part of the other span' do
      span = DeferredArray::Span.new 0, 2, 100
      other = DeferredArray::Span.new 3, 4, 100
      expect(span.overlaps?(other)).to be false
    end
  end

  describe '#covers_start?' do
    context 'when left starts before right' do
      context 'when left ends before right starts' do
        it 'is false' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 20, 30, 100
          expect(left.covers_start?(right)).to be false
        end
      end
      context 'when left ends where right starts' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 10, 30, 100
          expect(left.covers_start?(right)).to be true
        end
      end
      context 'when left ends after right starts' do
        context 'when left ends before right ends' do
          it 'is true' do
            left = DeferredArray::Span.new 5, 10, 100
            right = DeferredArray::Span.new 7, 30, 100
            expect(left.covers_start?(right)).to be true
          end
        end
        context 'when left ends where right ends' do
          it 'is true' do
            left = DeferredArray::Span.new 5, 30, 100
            right = DeferredArray::Span.new 20, 30, 100
            expect(left.covers_start?(right)).to be true
          end
        end
        context 'when left ends after right ends' do
          it 'is true' do
            left = DeferredArray::Span.new 5, 100, 100
            right = DeferredArray::Span.new 20, 30, 100
            expect(left.covers_start?(right)).to be true
          end
        end
      end
    end
    context 'when left starts where right starts' do
      context 'when left ends before right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_start?(right)).to be true
        end
      end
      context 'when left ends where right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 5, 10, 100
          expect(left.covers_start?(right)).to be true
        end
      end
      context 'when left ends after right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 100, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_start?(right)).to be true
        end
      end
    end
    context 'when left starts after right starts' do
      context 'when left ends before right ends' do
        it 'is false' do
          left = DeferredArray::Span.new 10, 20, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_start?(right)).to be false
        end
      end
      context 'when left ends where right ends' do
        it 'is false' do
          left = DeferredArray::Span.new 10, 30, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_start?(right)).to be false
        end
      end
      context 'when left ends after right ends' do
        it 'is false' do
          left = DeferredArray::Span.new 10, 100, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_start?(right)).to be false
        end
      end
    end
  end

  describe '#covers_end?' do
    context 'when left starts before right' do
      context 'when left ends before right starts' do
        it 'is false' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 20, 30, 100
          expect(left.covers_end?(right)).to be false
        end
      end
      context 'when left ends where right starts' do
        it 'is false' do
          left = DeferredArray::Span.new 5, 20, 100
          right = DeferredArray::Span.new 20, 30, 100
          expect(left.covers_end?(right)).to be false
        end
      end
      context 'when left ends after right starts' do
        context 'when left ends before right ends' do
          it 'is false' do
            left = DeferredArray::Span.new 5, 30, 100
            right = DeferredArray::Span.new 20, 50, 100
            expect(left.covers_end?(right)).to be false
          end
        end
        context 'when left ends where right ends' do
          it 'is true' do
            left = DeferredArray::Span.new 5, 30, 100
            right = DeferredArray::Span.new 20, 30, 100
            expect(left.covers_end?(right)).to be true
          end
        end
        context 'when left ends after right ends' do
          it 'is true' do
            left = DeferredArray::Span.new 5, 100, 100
            right = DeferredArray::Span.new 20, 30, 100
            expect(left.covers_end?(right)).to be true
          end
        end
      end
    end
    context 'when left starts where right starts' do
      context 'when left ends before right ends' do
        it 'is false' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_end?(right)).to be false
        end
      end
      context 'when left ends where right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 10, 100
          right = DeferredArray::Span.new 5, 10, 100
          expect(left.covers_end?(right)).to be true
        end
      end
      context 'when left ends after right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 5, 100, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_end?(right)).to be true
        end
      end
    end
    context 'when left starts after right starts' do
      context 'when left ends before right ends' do
        it 'is false' do
          left = DeferredArray::Span.new 10, 20, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_end?(right)).to be false
        end
      end
      context 'when left ends where right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 10, 30, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_end?(right)).to be true
        end
      end
      context 'when left ends after right ends' do
        it 'is true' do
          left = DeferredArray::Span.new 10, 200, 100
          right = DeferredArray::Span.new 5, 30, 100
          expect(left.covers_end?(right)).to be true
        end
      end
    end
    context 'when left starts after right ends' do
      it 'is false' do
        left = DeferredArray::Span.new 100, 200, 100
        right = DeferredArray::Span.new 5, 30, 100
        expect(left.covers_end?(right)).to be false
      end
    end
  end

  describe '.combine' do
    let(:left) { DeferredArray::Span.new left_start, left_end, 100 }
    let(:left_start) { 10 }
    let(:left_end) { 100 }

    let(:right) { DeferredArray::Span.new right_start, right_end, 2000 }
    let(:right_start) { 30 }
    let(:right_end) { 300 }

    it 'returns its results in order of indices' do
      expected = [
        DeferredArray::Span.new(10, 29, 100),
        DeferredArray::Span.new(30, 100, 2100),
        DeferredArray::Span.new(101, 300, 2000)
      ]

      expect(DeferredArray::Span.combine(left, right)).to eq expected
    end

    context 'when left and right are disjoint' do
      let(:left_end) { 20 }
      it 'is the Array containing left and right' do
        expect(DeferredArray::Span.combine(left, right)).to eq [left, right]
      end
    end

    context 'when left start is before right start' do
      context 'when left end is before right start' do
        let(:left_end) { 20 }
        it 'is left and right' do
          expect(DeferredArray::Span.combine(left, right)).to eq [left, right]
        end
      end
      context 'when left end is right start' do
        let(:left_end) { right_start }
        it 'is a triple of Spans pivoting on a Span of size 1' do
          expected = [
            DeferredArray::Span.new(left_start, left_end - 1, 100),
            DeferredArray::Span.new(left_end, left_end, 2100),
            DeferredArray::Span.new(left_end + 1, right_end, 2000)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is right start and right end' do
        let(:left_end) { right_start }
        let(:right_end) { right_start }
        it 'is a duple in which the second Span has size 1' do
          expected = [
            DeferredArray::Span.new(left_start, left_end - 1, 100),
            DeferredArray::Span.new(left_end, left_end, 2100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is before right end' do
        let(:left_end) { right_end - 1 }
        it 'is a triple of Spans pivoting on a Span of the intersection of left and right' do
          expected = [
            DeferredArray::Span.new(left_start, right_start - 1, 100),
            DeferredArray::Span.new(right_start, left_end, 2100),
            DeferredArray::Span.new(left_end + 1, right_end, 2000)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is right end' do
        let(:left_end) { right_end }
        it 'is a duple whose first element is the difference of left and right and whose second element is the intersection' do
          expected = [
            DeferredArray::Span.new(left_start, right_start - 1, 100),
            DeferredArray::Span.new(right_start, left_end, 2100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is after right end' do
        let(:left_end) { right_end + 1 }
        it 'is a triple pivoting on the right Span' do
          expected = [
            DeferredArray::Span.new(left_start, right_start - 1, 100),
            DeferredArray::Span.new(right_start, right_end, 2100),
            DeferredArray::Span.new(right_end + 1, left_end, 100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
    end
    context 'when left start is right start' do
      let(:left_start) { right_start }
      context 'when left end is before right end' do
        let(:left_end) { right_end - 1 }
        it 'is a duple whose first element is the intersection of left and right and whose second element is the difference' do
          expected = [
            DeferredArray::Span.new(left_start, left_end, 2100),
            DeferredArray::Span.new(left_end + 1, right_end, 2000)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is right end' do
        let(:left_end) { right_end }
        it 'is an Array of size one where the element has the value of left added to the value of right' do
          expected = [DeferredArray::Span.new(left_start, left_end, 2100)]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is after right end' do
        let(:left_end) { right_end + 1 }
        it 'is a duple whose first element is the intersection of left and right and whose second element is the difference' do
          expected = [
            DeferredArray::Span.new(left_start, right_end, 2100),
            DeferredArray::Span.new(right_end + 1, left_end, 100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
    end
    context 'when left start is after right start and before right end' do
      let(:left_start) { right_start + 1 }
      context 'when left end is before right end' do
        it 'is a triple of Spans pivoting on left but with the value of left added to right' do
          expected = [
            DeferredArray::Span.new(right_start, left_start - 1, 2000),
            DeferredArray::Span.new(left_start, left_end, 2100),
            DeferredArray::Span.new(left_end + 1, right_end, 2000)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is right end' do
        let(:left_end) { right_end }
        it 'is a duple whose first element is the difference of left and right and whose second element is the intersection' do
          expected = [
            DeferredArray::Span.new(right_start, left_start - 1, 2000),
            DeferredArray::Span.new(left_start, left_end, 2100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is after right end' do
        let(:left_end) { right_end + 1 }
        it 'is a triple pivoting on the Span of the intersection of right and left' do
          expected = [
            DeferredArray::Span.new(right_start, left_start - 1, 2000),
            DeferredArray::Span.new(left_start, right_end, 2100),
            DeferredArray::Span.new(right_end + 1, left_end, 100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
    end
    context 'when left start is right end' do
      let(:left_start) { right_end }
      context 'when left end is right end' do
        let(:left_end) { right_end }
        it 'is a duple whose second element has size one and whose value is the sum of left and right values' do
          expected = [
            DeferredArray::Span.new(right_start, left_start - 1, 2000),
            DeferredArray::Span.new(left_start, left_end, 2100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
      context 'when left end is after right end' do
        let(:left_end) { right_end + 1 }
        it 'is a triple pivoting on a Span of length 1 whose value is the sum of left and right values' do
          expected = [
            DeferredArray::Span.new(right_start, right_end - 1, 2000),
            DeferredArray::Span.new(right_end, left_start, 2100),
            DeferredArray::Span.new(left_start + 1, left_end, 100)
          ]
          expect(DeferredArray::Span.combine(left, right)).to eq expected
        end
      end
    end
    context 'when left start is after right end' do
      let(:left_start) { right_end + 1 }
      context 'when left end is after left start' do
        let(:left_end) { left_start + 1 }
        it 'is right and left' do
          expect(DeferredArray::Span.combine(left, right)).to eq [right, left]
        end
      end
      context 'when left end is left start' do
        let(:left_end) { left_start }
        it 'is right and left' do
          expect(DeferredArray::Span.combine(left, right)).to eq [right, left]
        end
      end
    end
  end
end

describe DeferredArray do
  describe 'getting the value for an index' do
    it 'is the value at the specified zero-based index' do
      da = DeferredArray.new 5, [
        DeferredArray::Span.new(0, 1, 100),
        DeferredArray::Span.new(1, 3, 100),
        DeferredArray::Span.new(2, 3, 100)
      ]
      expect(da[0]).to eq 100
      expect(da[1]).to eq 200
      expect(da[2]).to eq 200
      expect(da[3]).to eq 200
      expect(da[4]).to eq 0
    end
  end
end
