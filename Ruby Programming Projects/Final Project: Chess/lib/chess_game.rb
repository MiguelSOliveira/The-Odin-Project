require_relative 'chess_board'

class Game < Board
  PLAYER = [:one, :two]
  attr_reader :cur_player

  def initialize
    @cur_player = PLAYER[0]
    super
  end

  def switch_player
    @cur_player = (@cur_player == :one) ? :two : :one
  end

  

  def play from, to
    old_col_index = Game::LETTERS_TO_INDEX[from[1]]
    new_col_index = Game::LETTERS_TO_INDEX[to[1]]
    @board[to[0].to_i][new_col_index] = @board[from[0].to_i][old_col_index]
    @board[from[0].to_i][old_col_index] = '-'
  end
end
