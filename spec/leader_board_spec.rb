require 'spec_helper'
require 'leader_board'

describe LeaderBoard do
  describe '#rank' do
    it 'is the rank for the score' do
      high_scores = [100, 100, 50, 40, 40, 20, 10]
      lb = LeaderBoard.new high_scores
      expect(lb.rank(5)).to eq 6
      expect(lb.rank(24)).to eq 4
      expect(lb.rank(50)).to eq 2
      expect(lb.rank(120)).to eq 1
    end
  end
  describe '#ranks' do
    it 'is the ranks for the scores' do
      high_scores = [100, 100, 50, 40, 40, 20, 10]
      lb = LeaderBoard.new high_scores
      expect(lb.ranks([5, 24, 50, 120])).to eq [6, 4, 2, 1]
    end
  end
end
