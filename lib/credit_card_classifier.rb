class CreditCardClassifier
  CARD_TYPES = %i[electron visa amex discover jcb].freeze

  def first_two(cc)
    cc[0..1].to_i
  end

  def first_three(cc)
    cc[0..2].to_i
  end

  def first_four(cc)
    cc[0..3].to_i
  end

  def first_six(cc)
    cc[0..5].to_i
  end

  def visa?(cc)
    valid_lengths = [13, 16, 19]
    return true if cc[0] == '4' && valid_lengths.include?(cc.length)
    false
  end

  def amex?(cc)
    valid_starts = [34, 37]
    return true if cc.length == 15 && valid_starts.include?(first_two(cc))
    false
  end

  def discover?(cc)
    valid_lengths = [16, 17, 18, 19]
    return false unless valid_lengths.include? cc.length
    return true if [644, 645, 646, 647, 648, 649].include?(first_three(cc))
    return true if first_two(cc) == 65
    return true if first_four(cc) == 6011
    (622_126..622_925).cover?(first_six(cc))
  end

  def electron?(cc)
    return false unless visa? cc
    return false unless cc.length == 16
    return true if first_six(cc) == 417_500
    [4026, 4508, 4844, 4913, 4917].include?(first_four(cc))
  end

  def jcb?(cc)
    valid_lengths = [16, 17, 18, 19]
    valid_lengths.include?(cc.length) && (3528..3589).cover?(first_four(cc))
  end

  def classify(cc)
    CARD_TYPES.each do |card_type|
      # If the test hadn't called out the level of difficulty in adding new rules, I wouldn't have bothered with
      # using send, in favor of something less magical.
      return card_type.to_s if send "#{card_type}?", cc
    end
    'unknown'
  end
end
