class WordCounter
  def top_ten(input)
    cleaned = input.gsub /[!?'",.\n]/, ' '
    all_words = cleaned.split(' ').map(&:strip).map(&:downcase)
    @word_freq = {}
    all_words.each do |word|
      @word_freq[word] ||= 0
      @word_freq[word] += 1
    end
    @word_freq.map { |word, freq|
      { word: word, freq: freq }
    }.sort_by { |word_freq| word_freq[:freq] }.reverse[0..9]
  end

  def top_ten_from_file(filename)
    top_ten IO.read(filename)
  end
end

puts WordCounter.new.top_ten_from_file 'alice.txt'