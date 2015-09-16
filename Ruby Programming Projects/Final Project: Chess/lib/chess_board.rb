class Board
  COLS, ROWS = 8, 8
  BOARD_POSITION = Array.new(COLS) { Array.new(ROWS, "-") }
  KING_WHITE, QUEEN_WHITE, ROOK_WHITE, BISHOP_WHITE, KNIGHT_WHITE, PAWN_WHITE = "\u2654".encode("utf-8"), "\u2655".encode("utf-8"), "\u2656".encode("utf-8"), "\u2657".encode("utf-8"), "\u2658".encode("utf-8"), "\u2659".encode("utf-8")
  KING_BLACK, QUEEN_BLACK, ROOK_BLACK, BISHOP_BLACK, KNIGHT_BLACK, PAWN_BLACK = "\u265A".encode("utf-8"), "\u265B".encode("utf-8"), "\u265C".encode("utf-8"), "\u265D".encode("utf-8"), "\u265E".encode("utf-8"), "\u265F".encode("utf-8")
  attr_reader :board

  def clear_board
    @board = Array.new(ROWS) { Array.new(COLS) }
  end

  def initialize
    BOARD_POSITION[0][0], BOARD_POSITION[0][1], BOARD_POSITION[0][2], BOARD_POSITION[0][3], BOARD_POSITION[0][4], BOARD_POSITION[0][5], BOARD_POSITION[0][6], BOARD_POSITION[0][7] = ROOK_WHITE, KNIGHT_WHITE, BISHOP_WHITE, KING_WHITE, QUEEN_WHITE, BISHOP_WHITE, KNIGHT_WHITE, ROOK_WHITE
    BOARD_POSITION[1][0], BOARD_POSITION[1][1], BOARD_POSITION[1][2], BOARD_POSITION[1][3], BOARD_POSITION[1][4], BOARD_POSITION[1][5], BOARD_POSITION[1][6], BOARD_POSITION[1][7] = PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE, PAWN_WHITE

    BOARD_POSITION[7][0], BOARD_POSITION[7][1], BOARD_POSITION[7][2], BOARD_POSITION[7][3], BOARD_POSITION[7][4], BOARD_POSITION[7][5], BOARD_POSITION[7][6], BOARD_POSITION[7][7] = ROOK_BLACK, KNIGHT_BLACK, BISHOP_BLACK, KING_BLACK, QUEEN_BLACK, BISHOP_BLACK, KNIGHT_BLACK, ROOK_BLACK
    BOARD_POSITION[6][0], BOARD_POSITION[6][1], BOARD_POSITION[6][2], BOARD_POSITION[6][3], BOARD_POSITION[6][4], BOARD_POSITION[6][5], BOARD_POSITION[6][6], BOARD_POSITION[6][7] = PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK, PAWN_BLACK
  end

  def print_board
    puts "    A   B   C   D   E   F   G   H"
    indexes = [7,6,5,4,3,2,1,0]
    board_array = BOARD_POSITION.zip(indexes)
    board_array.each do |row, index|
      print "#{index} | "
      row.each do |piece|
        print "#{piece} | "
      end
      puts "#{index}"
    end
    puts "    A   B   C   D   E   F   G   H"
  end
end
g = Board.new
g.print_board