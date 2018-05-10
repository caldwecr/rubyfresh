require 'spec_helper'
require 'longest_palindrome'

describe LongestPalindrome do
  describe '.palindrome?' do
    it 'is true for palindromes' do
      expect(LongestPalindrome.palindrome?('racecar')).to be true
    end
    it 'is false for non palindromes' do
      expect(LongestPalindrome.palindrome?('abab')).to be false
    end
    it 'is case insensitive' do
      expect(LongestPalindrome.palindrome?('rAcEcAR')).to be true
    end
    it 'ignores spaces in the middle of the string' do
      expect(LongestPalindrome.palindrome?('ra CeCaR')).to be true
    end
    it 'is false if the length is less than 2' do
      expect(LongestPalindrome.palindrome?('a')).to be false
    end
  end

  # describe '.palindromes' do
  #   it 'is an Array containing all of the palindromes' do
  #     expect(LongestPalindrome.palindromes('I went to the gym yesterday')).to eq [' my gym ']
  #   end
  # end

  describe '.longest' do
    it 'is the longest palindrome' do
      expect(LongestPalindrome.longest('racecar')).to eq 'racecar'
      expect(LongestPalindrome.longest('a racecar b')).to eq ' racecar '
      expect(LongestPalindrome.longest('I went to my gym yesterday')).to eq ' my gym '
    end
  end
end
