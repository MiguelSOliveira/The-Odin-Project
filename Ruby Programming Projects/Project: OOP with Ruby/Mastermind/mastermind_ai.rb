require_relative "codemaker"
require_relative "codebreaker"

LENGTH = 4
TRIES = 12

def new_game
  code_maker = CodeMaker.new LENGTH
  code_maker.generate_code
  puts CodeMaker.code
  code_breaker = CodeBreaker.new LENGTH
  won = false
  try = code_breaker.generate_code_breaker [], [], "1122"

  TRIES.times do
    break if won
    correct_indexes, wrong_indexes = code_breaker.try_code(try.to_s)
    puts "I'm guessing.... #{try}"
    puts '["' + correct_indexes + '","' + wrong_indexes + '"]'
    try = code_breaker.generate_code_breaker correct_indexes, wrong_indexes, try
    won = true if correct_indexes.size == LENGTH
    gets
  end
  puts won ? "I won in just #{CodeBreaker.tries} tries!" : "I lost!"
end
new_game
