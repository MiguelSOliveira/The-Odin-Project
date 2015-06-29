require_relative "codemaker"
require_relative "codebreaker"

LENGTH = 4
TRIES = 12

def new_game
  code_maker = CodeMaker.new LENGTH
  code_maker.generate_code
  puts CodeMaker.code
  code_breaker = CodeBreaker.new LENGTH
  won = nil

  TRIES.times do
    feedback = code_breaker.try_code(gets.chomp)
    puts "#{feedback} #{12-CodeBreaker.tries} tries remaining"
    won = feedback[0].size == LENGTH ? true : false
    break if won
  end
  puts won ? "You won!" : "You lost!"
  return
end
new_game
