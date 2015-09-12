class Player
  @@turns = 0
  attr_accessor :name

  def initialize piece, name
    @piece = piece
    @name = name
  end

  def self.turns
    @@turns
  end

  def check_victory
    #Check horizontal
    (0..6).step(3) do |i|
      return true if $board[i] == @piece and $board[i] == $board[i+1] and $board[i+1] == $board[i+2]
    end
    #Check vertical
    3.times do |i|
      return true if $board[i] == @piece and $board[i] == $board[i+3] and $board[i+3] == $board[i+6]
    end
    # Check main diagonal
    return true if $board[0] == @piece and $board[0] == $board[4] and $board[4] == $board[8]
    # Check secondary diagonal
    return true if $board[2] == @piece and $board[2] == $board[4] and $board[4] == $board[6]

    return false
  end

  def play index
    return false unless index.between?(1,9) and $board[index-1].is_a? Integer

    @@turns += 1
    $board[index-1] = @piece
  end
end

class Board
  $board = [1,2,3,4,5,6,7,8,9]

  def print_board
    k = 0
    3.times do |i|
      puts "#{$board[i+k]} | #{$board[i+k+1]} | #{$board[i+k+2]}"
      puts "---------" if i < 2
      k += 2
    end
    puts
  end

  def check_tie

    0.upto(8) do |i|
      return false if $board[i].is_a? Integer
    end
    return true
  end
end

def new_game

  board_game = Board.new
  board_game.print_board
  players = []
  puts "Enter name for player 1"
  # name = gets.chomp
  name = "Miguel"
  players << Player.new('X', name)
  puts "Enter name for player 2"
  name = "No idea"
  players << Player.new('O', name)
  turn = 0
  won = nil

  loop do
    puts "Turn #{Player.turns}"
    puts "Where do you want to Play, #{players[turn].name}?"
    index = gets.chomp.to_i
    if turn == 0
      if not players[0].play index then next end
    else
      if not players[1].play index then next end
    end
    board_game.print_board
    won = 1 if players[0].check_victory
    won ||= 2 if players[1].check_victory
    won ||= 0 if board_game.check_tie
    break if won
    if turn == 1 then turn = 0 else turn = 1 end
  end

  return "#{players[0].name} won at turn #{Player.turns}!" if won == 1
  return "#{players[1].name} won at turn #{Player.turns}!" if won == 2
  return "It's a tie at turn #{Player.turns}!"
end
puts new_game
