class Board
  COLS, ROWS = 8, 8
  KING_WHITE, QUEEN_WHITE, ROOK_WHITE, BISHOP_WHITE, KNIGHT_WHITE, PAWN_WHITE = "\u2654".encode("utf-8"), "\u2655".encode("utf-8"), "\u2656".encode("utf-8"), "\u2657".encode("utf-8"), "\u2658".encode("utf-8"), "\u2659".encode("utf-8")
  KING_BLACK, QUEEN_BLACK, ROOK_BLACK, BISHOP_BLACK, KNIGHT_BLACK, PAWN_BLACK = "\u265A".encode("utf-8"), "\u265B".encode("utf-8"), "\u265C".encode("utf-8"), "\u265D".encode("utf-8"), "\u265E".encode("utf-8"), "\u265F".encode("utf-8")
  attr_reader :board

  def clear_board
    @board = Array.new(ROWS) { Array.new(COLS) }
  end
end
