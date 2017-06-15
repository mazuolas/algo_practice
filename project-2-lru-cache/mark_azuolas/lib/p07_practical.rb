require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  letters = {}
  string.each_char { |char| letters[char] ? letters[char] += 1 : letters[char] = 1 }
  odds = 0
  letters.each_value do |val|
    odds += 1 if val.odd?
  end
  odds < 2
end
