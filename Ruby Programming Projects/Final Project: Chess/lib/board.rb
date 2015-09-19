require 'ostruct'

class Board
  COLS, ROWS = 8, 8
  LETTERS_TO_INDEX = { 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8 }
  KING_WHITE, QUEEN_WHITE, ROOK_WHITE, BISHOP_WHITE, KNIGHT_WHITE, PAWN_WHITE = "\u2654".encode("utf-8"), "\u2655".encode("utf-8"), "\u2656".encode("utf-8"), "\u2657".encode("utf-8"), "\u2658".encode("utf-8"), OpenStruct.new
  PAWN_WHITE.name = "\u2659".encode("utf-8")
  PAWN_WHITE.count = 0
  KING_BLACK, QUEEN_BLACK, ROOK_BLACK, BISHOP_BLACK, KNIGHT_BLACK, PAWN_BLACK = "\u265A".encode("utf-8"), "\u265B".encode("utf-8"), "\u265C".encode("utf-8"), "\u265D".encode("utf-8"), "\u265E".encode("utf-8"), OpenStruct.new
  PAWN_BLACK.name = "\u265F".encode("utf-8")
  PAWN_BLACK.count = 0
  attr_reader :board

  def clear_board
    @board = Array.new(COLS) { Array.new(ROWS, "-") }
  end

  
end
