def main
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  sentence = "Howdy partner, sit down! How's it going?".split
  substrings = {}

  dictionary.each do |dict_word|
    sentence.each do |sentence_word|
      if sentence_word.downcase.include? dict_word
        if substrings[dict_word] == nil
          substrings[dict_word] = 1
        else
          substrings[dict_word] += 1
        end
      end
    end
  end
  puts substrings #=> {"down"=>1, "go"=>1, "going"=>1, "how"=>2, "howdy"=>1, "it"=>2, "i"=>3, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1}
end
main
