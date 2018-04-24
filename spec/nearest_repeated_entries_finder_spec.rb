require 'spec_helper'
require 'nearest_repeated_entries_finder'

describe NearestRepeatedEntriesFinder do
  describe '.find' do
    it 'is the indices of the nearest repeated entry' do
      expect(NearestRepeatedEntriesFinder.find(
               %w[dog cat mouse dog mouse]
      )).to eq [2, 4]
    end

    context 'when more than one repeated entry of the shortest separation exists' do
      it 'is the indices of the first occurring pair of those pairs separated by the shortest distance' do
        canonical_example = %w[All work and no play makes for no work no fun and no results]
        expect(NearestRepeatedEntriesFinder.find(canonical_example)).to eq [7, 9]
      end
    end

    context 'when no entries are repeated' do
      it 'is the empty Array' do
        expect(NearestRepeatedEntriesFinder.find(%i[foo bar])).to eq []
      end
    end
  end
end
