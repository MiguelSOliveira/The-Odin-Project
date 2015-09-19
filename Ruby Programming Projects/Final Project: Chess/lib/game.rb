require_relative 'board'

class Game < Board
  PLAYER = [:one, :two]
  attr_reader :cur_player

  def initialize
    @cur_player = PLAYER[0]
    super
  end

  def move_piece from, to
    return false if @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] == '-' or out_of_bounds(from, to)

    @board[to[0].to_i][LETTERS_TO_INDEX[to[1]]] = @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]]
    @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] = '-'
    return true
  end

  def out_of_bounds from, to
    return true if not from[0].to_i.between?(0, COLS-1)
    return true if not to[0].to_i.between?(0, COLS-1)
    return true if not LETTERS_TO_INDEX[from[1]]
    return true if not LETTERS_TO_INDEX[to[1]]
    return false
  end

end
