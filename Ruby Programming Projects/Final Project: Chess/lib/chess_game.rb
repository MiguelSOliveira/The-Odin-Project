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

  def valid_play_for_pawn? pawn, from, to
    if pawn == PAWN_WHITE

    else

    end
  end

  def valid_play? piece, from, to
    if piece == PAWN_WHITE or piece == PAWN_BLACK
      return valid_play_for_pawn? piece, from, to
    end
  end

  def play from, to
    old_col_index = Game::LETTERS_TO_INDEX[from[1]]
    new_col_index = Game::LETTERS_TO_INDEX[to[1]]
    @board[to[0].to_i][new_col_index] = @board[from[0].to_i][old_col_index]
    @board[from[0].to_i][old_col_index] = '-'
  end
end