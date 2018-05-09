# Checks to see if two strings are isomorphic to each other
class IsomorphismDetector
  attr_accessor :str_a, :str_b
  attr_reader :a_to_b, :b_to_a
  def initialize(str_a, str_b)
    @str_a = str_a
    @str_b = str_b
    @a_to_b = {}
    @b_to_a = {}
  end

  def isomorphic?
    chars_a = str_a.chars
    chars_b = str_b.chars
    chars_a.each_with_index do |char, idx|
      if a_to_b.key? char
        return false unless b_to_a.key? chars_b[idx]

        #   a_to_b[char] must be chars_b[idx]
        return false unless a_to_b[char] == chars_b[idx]

        #   b_to_a[chars_b[idx]] must be char
        return false unless b_to_a[chars_b[idx]] == char
      else
        return false if b_to_a.key? chars_b[idx]
        a_to_b[char] = chars_b[idx]
        b_to_a[chars_b[idx]] = char
      end
    end
    true
  end

  def self.isomorphic?(str_a, str_b)
    IsomorphismDetector.new(str_a, str_b).isomorphic?
  end
end
