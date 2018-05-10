# Class for the Hackerrank climbing the leaderboard challenge
class LeaderBoard
  attr_reader :high_scores

  def initialize(high_scores = [])
    @high_scores = high_scores
  end

  def rank(score)
    curr_rank = 1
    last_high = nil
    high_scores.each do |curr|
      return curr_rank if score >= curr
      curr_rank += 1 if last_high.nil? || curr < last_high
      last_high = curr
    end
    curr_rank
  end

  def ranks(scores)
    scores_with_orig_idx = []
    scores.each_with_index do |score, idx|
      scores_with_orig_idx << { score: score, orig_idx: idx }
    end
    sorted_scores_with_orig_idx = scores_with_orig_idx.sort_by { |score_with_orig_idx| score_with_orig_idx[:score] }.reverse
    ranks = ranks_for_sorted_scores(sorted_scores_with_orig_idx.map { |score| score[:score] })
    scores_with_ranks = []
    sorted_scores_with_orig_idx.each_with_index do |score_with_orig_idx, idx|
      scores_with_ranks << {
        score: score_with_orig_idx[:score],
        orig_idx: score_with_orig_idx[:orig_idx],
        rank: ranks[idx]
      }
    end
    scores_with_ranks.sort_by { |score_with_rank| score_with_rank[:orig_idx] }.map { |score_with_rank| score_with_rank[:rank] }
  end

  private

  def ranks_for_sorted_scores(sorted_scores)
    curr_rank = 1
    last_high = nil
    h = 0 # idx position in high_scores
    s = 0 # idx position in sorted_scores
    ranks = []
    while s < sorted_scores.length
      if h >= high_scores.length
        ranks << curr_rank + 1
        s += 1
      else
        if last_high.nil?
          last_high = high_scores[h]
        elsif last_high > high_scores[h]
          curr_rank += 1
          last_high = high_scores[h]
        end

        if sorted_scores[s] < high_scores[h]
          h += 1
        else
          ranks << curr_rank
          s += 1
        end
      end
    end
    ranks
  end
end
