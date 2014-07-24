# This program calculates the index rank of a specific word(@my_word) in a list
# of all words alphabetically sorted using the same letters that are
# contained in the word

# The program first calculates the total number of possible letter combinations
# and then compares @my_word to a word with the same letters sorted alphabetically.
# It then calculates the rank of @my_word by using factorials to calculate the
# possible number of words that can be created with that letter in that position
# By comparing each letter one at a time, we can find the exact rank of the word

require 'pry'
@my_word = ''

# Get word input from user
until @my_word.length.between?(1,20)
  print 'Please enter a word(1-20 chars): '
  @my_word = gets.chomp.upcase
end

# Calculates factorial(n!) recursively
def factorial(num)
  num <= 1 ? 1 : num * factorial(num - 1)
end

# Calculates rank of @my_word in alphabetical list of
# all possible character combinations
def find_rank
  rank = 1
  count = 1
  sorted = @my_word.chars.sort.join

  @my_word.each_char do |letter|
    # puts "#{letter} - #{sorted.chars}"

    position = sorted.index(letter)
    if all_letters_uniq?
      # puts "Adding #{factorial(@my_word.length - count) * position}"
      rank += factorial(@my_word.length - count) * position
    else
      word_count = @my_word.count letter
      # puts "Adding #{(factorial(@my_word.length - count) / dups_denominator(sorted)) * position}"
      rank += (factorial(@my_word.length - count) / dups_denominator(sorted)) * position
    end
    # puts "Rank: #{rank} - Count: #{count}"
    sorted.slice!(position)
    count += 1
  end
  puts "Rank: #{rank}"
  rank
end

# Returns number of letter combination possibilities for @my_word
def possibilities
  factorial(@my_word.length) / dups_denominator(@my_word)
end

# Check if letter is unique in word
def all_letters_uniq?
  @my_word.chars.each do |letter|
    return false if (@my_word.count letter) > 1
  end
  true
end

# Returns denominator for factorial calculation based on letters
# that are repeated in passed word parameter
def dups_denominator(word)
  sum = 1

  word.chars.uniq.each do |unique_letter|
    word_count = word.count unique_letter
    sum *= factorial(word_count) if (word_count) > 1
  end

  sum
end

puts "Word  : #{@my_word}"
puts "Sorted: #{@my_word.chars.sort.join}"
puts "Length: #{@my_word.length} / Unique: #{@my_word.chars.uniq.length}"
puts "Possibilities: #{possibilities}"
find_rank


