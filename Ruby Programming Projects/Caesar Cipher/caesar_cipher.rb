def caesar_cipher sentence, shift
  (0...sentence.size).each do |index|
    if not (('A'..'Z').include?(sentence[index]) or ('a'..'z').include?(sentence[index])) or shift <= 0 # if its not a letter skip iteration
      next
    elsif sentence[index] == sentence[index].upcase
      alphabet = ('A'..'Z').cycle.each
    else
      alphabet = ('a'..'z').cycle.each
    end
    found = false
    while not found # find index of letter from which to iterate from
      x = alphabet.next
      found = true if x == sentence[index]
    end
    (0...shift-1).each {alphabet.next} # do iterations from that letter "shift" times
    sentence[index] = alphabet.next
  end
  return sentence
end
puts caesar_cipher ARGV[0].dup, ARGV[1].to_i
