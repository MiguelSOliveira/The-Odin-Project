require_relative 'board'

class Game < Board
  PLAYER = [:one, :two]
  attr_reader :cur_player

  def initialize
    @cur_player = PLAYER[0]
    super
  end

  def move_piece from, to
    return false if @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] == '-'

    @board[to[0].to_i][LETTERS_TO_INDEX[to[1]]] = @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]]
    @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] = '-'
    return true
  end

end


g = Game.new
g.print_board
