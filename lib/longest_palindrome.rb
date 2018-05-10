class LongestPalindrome
  def self.palindrome?(str)
    i = 0
    j = str.length - 1
    chars = str.downcase.chars
    return false if chars.length < 2
    while i < j
      while chars[i] == ' ' && i < j
        i += 1
      end
      while chars[j] == ' ' && i < j
        j -= 1
      end
      return false if chars[i] != chars[j]
      i += 1
      j -= 1
    end
    true
  end

  def self.longest(str)
    i = 0
    j = str.length - 1
    curr_longest = ''
    while i < j
      if j - i < curr_longest.length
        i += 1
        j = str.length - 1
      end
      curr = str[i..j]
      curr_longest = curr if palindrome?(curr) && curr.length > curr_longest.length
      return '' if i == str.length - 1
      j -= 1
      if i == j
        i += 1
        j = str.length - 1
      end
    end
    curr_longest
  end
end
