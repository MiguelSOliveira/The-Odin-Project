require 'ostruct'

class Board
  COLS, ROWS = 8, 8
  LETTERS_TO_INDEX = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }
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

  def get_colour_at square
    return "WHITE" if (get_piece_at square).include?("WHITE")
    return "BLACK" if (get_piece_at square).include?("BLACK")
    return "OTHER"
  end

  def find_letter letter, spaces
    letters = ['A','B','C','D','E','F','G','H']
    letter = letters[letters.index(letter) + spaces]
    return letter
  end

  def valid_play_for_knight from, to
    return false if (get_piece_at to).include?(get_colour_at from)

    plays = [[-2,1], [-1,2], [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1]]
    possible_moves = []

    plays.each do |play|
      new_index = (from[0].to_i+play[0]).to_s
      new_letter = find_letter(from[1], play[1])
      possible_moves.push ( new_index + new_letter )
    end
    return true if possible_moves.include?(to)
    return false
  end

  def valid_play_for_rook from, to
    return false unless from[0] == to[0] or from[1] == to[1]
    return false if (get_piece_at to).include?(get_colour_at from)

    if from[1] == to[1]
      from[0], to[0] = to[0], from[0] if from[0].to_i > to[0].to_i
      ((from[0].to_i+1)...to[0].to_i).each do |index|
        return false if @board[index][LETTERS_TO_INDEX[from[1]]] != '-'
      end
    else
      from[1], to[1] = to[1], from[1] if LETTERS_TO_INDEX[from[1]] > LETTERS_TO_INDEX[to[1]]
      ((LETTERS_TO_INDEX[from[1]]+1)...LETTERS_TO_INDEX[to[1]].to_i).each do |letter|
        return false if @board[from[0].to_i][letter] != '-'
      end
    end
    return true
  end

  def valid_play_for_king from, to
    return false if (get_piece_at to).include?(get_colour_at(from))

    plays = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]
    possible_moves = []

    plays.each do |play|
      new_index = (from[0].to_i + play[0]).to_s
      new_letter = find_letter(from[1], play[1])
      possible_moves.push ( new_index + new_letter )
    end
    return true if possible_moves.include?(to)
    return false
  end

  def decrement_both square
    if square[0].to_i > 0
      new_index  = (square[0].to_i - 1).to_s
    else
      new_index = square[0]
    end
    if LETTERS_TO_INDEX[square[1]] > 0 and square[0].to_i > 0
      new_letter = (square[1].ord-1).chr
    else
      new_letter = square[1]
    end
    return ( new_index + new_letter )
  end

  def decrement_letters square
    if square[0].to_i < 7
      new_index  = (square[0].to_i + 1).to_s
    else
      new_index = square[0]
    end
    if LETTERS_TO_INDEX[square[1]] > 0 and square[0].to_i < 7
      new_letter = (square[1].ord - 1).chr
    else
      new_letter = square[1]
    end
    return ( new_index + new_letter )
  end

  def increment_both square
    if square[0].to_i < 7
      new_index = (square[0].to_i + 1).to_s
    else
      new_index = square[0]
    end
    if LETTERS_TO_INDEX[square[1]] < 7 and square[0].to_i < 7
      new_letter = (square[1].ord + 1).chr
    else
      new_letter = square[1]
    end
    return ( new_index + new_letter )
  end

  def decrement_index square
    if square[0].to_i > 0
      new_index = (square[0].to_i - 1).to_s
    else
      new_index = square[0]
    end
    if LETTERS_TO_INDEX[square[1]] < 7 and square[0].to_i > 0
      new_letter = (square[1].ord + 1).chr
    else
      new_letter = square[1]
    end
    return ( new_index + new_letter )
  end

  def check_empty_square possible_moves, cur_square
    if @board[cur_square[0].to_i][LETTERS_TO_INDEX[cur_square[1]]] == '-'
      possible_moves.push cur_square
    end
    return possible_moves
  end

  def valid_play_for_bishop from, to
    return false if (get_piece_at to).include?(get_colour_at(from))

    possible_moves = []
    cur_square = from
    # 0A, 1B diagonal
    while cur_square[0].to_i >= 0 and LETTERS_TO_INDEX[cur_square[1]] >= 0
      cur_square = decrement_both cur_square
      possible_moves = check_empty_square(possible_moves, cur_square)
      break if decrement_both(cur_square) == cur_square
    end
    cur_square = from
    # 7A, 6B diagonal
    while cur_square[0].to_i <= 7 and LETTERS_TO_INDEX[cur_square[1]] >= 0
      cur_square = decrement_letters cur_square
      possible_moves = check_empty_square(possible_moves, cur_square)
      break if decrement_letters(cur_square) == cur_square
    end
    cur_square = from
    # 7H, 6G diagonal
    while cur_square[0].to_i <= 7 and LETTERS_TO_INDEX[cur_square[1]] <= 7
      cur_square = increment_both cur_square
      possible_moves = check_empty_square(possible_moves, cur_square)
      break if increment_both(cur_square) == cur_square
    end
    cur_square = from
    # 0H, 1G diagonal
    while cur_square[0].to_i >= 0 and LETTERS_TO_INDEX[cur_square[1]] <= 7
      cur_square = decrement_index cur_square
      possible_moves = check_empty_square(possible_moves, cur_square)
      break if decrement_index(cur_square) == cur_square
    end
    return true if possible_moves.include?(to)
    return false
  end

  def valid_play_for_queen from, to
    return true if valid_play_for_rook(from, to) or valid_play_for_bishop(from, to)
    return false
  end
end
