require_relative "codemaker"

class CodeBreaker < CodeMaker
  @@tries = 0
  @@numbers_used_index = ["","","",""]

  def self.tries
    @@tries
  end

  def try_code code
    @@tries += 1
    return compare_code code
  end

  def generate_code_breaker correct_indexes, wrong_indexes, last_try
    code = ""
    i = 0
    loop do
      break if code.size == 4
      if correct_indexes.include? i.to_s
        code << last_try[i]
        i += 1
        next
      end
      random_number = rand(1..6).to_s
      next if @@numbers_used_index[i].include? random_number
      code << random_number
      @@numbers_used_index[i] << random_number
      i += 1
    end
    code
  end
end
