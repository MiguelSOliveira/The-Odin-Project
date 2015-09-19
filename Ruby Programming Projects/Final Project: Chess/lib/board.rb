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

  def initialize
    @board = Array.new(COLS) { Array.new(ROWS, "-") }

    @board[0][0], @board[0][1], @board[0][2], @board[0][3], @board[0][4], @board[0][5], @board[0][6], @board[0][7] = ROOK_WHITE, KNIGHT_WHITE, BISHOP_WHITE, KING_WHITE, QUEEN_WHITE, BISHOP_WHITE, KNIGHT_WHITE, ROOK_WHITE
    @board[1][0], @board[1][1], @board[1][2], @board[1][3], @board[1][4], @board[1][5], @board[1][6], @board[1][7] = PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE

    @board[7][0], @board[7][1], @board[7][2], @board[7][3], @board[7][4], @board[7][5], @board[7][6], @board[7][7] = ROOK_BLACK, KNIGHT_BLACK, BISHOP_BLACK, KING_BLACK, QUEEN_BLACK, BISHOP_BLACK, KNIGHT_BLACK, ROOK_BLACK
    @board[6][0], @board[6][1], @board[6][2], @board[6][3], @board[6][4], @board[6][5], @board[6][6], @board[6][7] = PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK
  end

  def print_board
    puts "    A   B   C   D   E   F   G   H"
    @board.each_with_index do |row, index|
      print "#{index} | "
      row.each do |piece|
        if piece == PAWN_WHITE or piece == PAWN_BLACK
          print "#{piece.name} | "
        else
          print "#{piece} | "
        end
      end
      puts "#{index}"
    end
    puts "    A   B   C   D   E   F   G   H"
  end
end
