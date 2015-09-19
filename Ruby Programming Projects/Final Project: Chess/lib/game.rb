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

  def get_piece_at square
    piece = @board[square[0].to_i][LETTERS_TO_INDEX[square[1]]]
    case piece
    when '-'
      return '-'
    when PAWN_WHITE
      return "PAWN_WHITE"
    when ROOK_WHITE
      return "ROOK_WHITE"
    when KNIGHT_WHITE
      return "KNIGHT_WHITE"
    when BISHOP_WHITE
      return "BISHOP_WHITE"
    when KING_WHITE
      return "KING_WHITE"
    when QUEEN_WHITE
      return "QUEEN_WHITE"
    when PAWN_BLACK
      return "PAWN_BLACK"
    when ROOK_BLACK
      return "ROOK_BLACK"
    when KNIGHT_BLACK
      return "KNIGHT_BLACK"
    when BISHOP_BLACK
      return "BISHOP_BLACK"
    when KING_BLACK
      return "KING_BLACK"
    when QUEEN_BLACK
      return "QUEEN_BLACK"
    end
  end

end
