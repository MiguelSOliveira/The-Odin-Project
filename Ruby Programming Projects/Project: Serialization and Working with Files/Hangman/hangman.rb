require 'yaml'

class Player
  attr_accessor :secret_word, :public_word, :wrong_guesses, :tries
end

def pick_word(file)
  default_word = file.readline.chomp
  file.each_line do |word|
    return word.chomp.downcase if rand(1..22000) > 21999
  end
  return default_word.downcase
end

def find_indices(word, letter)
  indices = []
  word.split("").each_with_index do |character, index|
    indices << index if character == letter
  end
  return indices
end

def replace_at(word, indices, replacement)
  indices.each { |index| word[index] = replacement }
  return word
end

def save_game(player)
  puts "Saving game"
  File.delete("saved_games.txt") if File.exist?("saved_games.txt")
  File.open("saved_games.txt", "a") do |file|
    file.puts(player)
  end
end

def load_game(player, load)
  if not load
    player.wrong_guesses = ""
    player.tries = player.public_word.size * 2
  end
  puts "#{player.public_word} #{player.tries} tries remaining"
  puts "Wrong guesses: #{player.wrong_guesses}"
  return player
end

def choose_word
  File.open("new_5desk.txt", "r") do |file|
    secret_word = pick_word(file)
    public_word = "".rjust(secret_word.size, '_')
    return [secret_word, public_word]
  end
end

def create_player(choice)
  if choice == "yes"
    if not File.exist?("saved_games.txt")
      puts "No saved games available"
      player, load = create_player("no")
    else
      player = YAML::load_file(File.open("saved_games.txt"))
      load = true
    end
  else
    secret_word, public_word = choose_word
    player = Player.new
    player.secret_word = secret_word
    player.public_word = public_word
    load = false
  end
  return [player, load]
end

def play(player, load)
  game_over = nil
  load_game(player, load)
  until game_over
    puts "Choose a letter (write exit if you want to stop playing or save if you want to save the game)"
    guess = gets.chomp.downcase
    save_game(YAML::dump(player)) if guess == "save"
    break if guess == "exit"

    next if player.wrong_guesses.include? guess or guess.size > 1
    player.wrong_guesses << guess + " " if not player.secret_word.include?(guess)

    indices = find_indices(player.secret_word, guess)
    player.tries -= 1 if indices.empty?
    player.public_word = replace_at(player.public_word, indices, guess)

    puts "#{player.public_word} #{player.tries} tries remaining"
    puts "Wrong guesses: #{player.wrong_guesses}"

    game_over = 1 if not player.public_word.include?("_")
    game_over = 2 if player.tries <= 0
  end
  return "You won!" if game_over == 1
  return "You lost, the word was #{player.secret_word}!" if game_over == 2
end

def main
  puts "Would you like to load the last saved game? (yes or no)"

  player, load = create_player(gets.chomp.downcase)
  puts play(player, load)
end
main
