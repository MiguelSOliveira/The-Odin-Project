require 'ostruct'

class Pawn
  attr_accessor :count
  attr_reader :name, :colour

  def initialize colour
    @count = 0
    @colour = colour
    colour_piece
  end

  def colour_piece
    if @colour == "WHITE"
      @name = "\u2659".encode("utf-8")
    else
      @name = "\u265F".encode("utf-8")
    end
  end
end

class Board
  COLS, ROWS = 8, 8
  LETTERS_TO_INDEX = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7 }
  KING_WHITE, QUEEN_WHITE, ROOK_WHITE, BISHOP_WHITE, KNIGHT_WHITE = "\u2654".encode("utf-8"), "\u2655".encode("utf-8"), "\u2656".encode("utf-8"), "\u2657".encode("utf-8"), "\u2658".encode("utf-8")
  KING_BLACK, QUEEN_BLACK, ROOK_BLACK, BISHOP_BLACK, KNIGHT_BLACK = "\u265A".encode("utf-8"), "\u265B".encode("utf-8"), "\u265C".encode("utf-8"), "\u265D".encode("utf-8"), "\u265E".encode("utf-8")
  attr_accessor :board, :king_white, :king_black

  def clear_board
    @board = Array.new(COLS) { Array.new(ROWS, "-") }
  end

  def initialize
    @board = Array.new(COLS) { Array.new(ROWS, "-") }
    @king_white = "0D"
    @king_black = "7D"

    @board[0][0], @board[0][1], @board[0][2], @board[0][3], @board[0][4], @board[0][5], @board[0][6], @board[0][7] = ROOK_WHITE, KNIGHT_WHITE, BISHOP_WHITE, KING_WHITE, QUEEN_WHITE, BISHOP_WHITE, KNIGHT_WHITE, ROOK_WHITE
    @board[1][0], @board[1][1], @board[1][2], @board[1][3], @board[1][4], @board[1][5], @board[1][6], @board[1][7] = Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE"), Pawn.new("WHITE")

    @board[7][0], @board[7][1], @board[7][2], @board[7][3], @board[7][4], @board[7][5], @board[7][6], @board[7][7] = ROOK_BLACK, KNIGHT_BLACK, BISHOP_BLACK, KING_BLACK, QUEEN_BLACK, BISHOP_BLACK, KNIGHT_BLACK, ROOK_BLACK
    @board[6][0], @board[6][1], @board[6][2], @board[6][3], @board[6][4], @board[6][5], @board[6][6], @board[6][7] = Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK"), Pawn.new("BLACK")
  end

  def print_board
    puts "           W H I T E             "
    puts "    A   B   C   D   E   F   G   H"
    @board.each_with_index do |row, index|
      print "#{index} | "
      row.each do |piece|
        if piece.instance_of?(Pawn)
          print "#{piece.name} | "
        else
          print "#{piece} | "
        end
      end
      puts "#{index}"
    end
    puts "    A   B   C   D   E   F   G   H"
    puts "           B L A C K             "
  end

  def out_of_bounds from, to
    return true if not from[0].to_i.between?(0, COLS-1)
    return true if not to[0].to_i.between?(0, COLS-1)
    return true if not LETTERS_TO_INDEX[from[1]]
    return true if not LETTERS_TO_INDEX[to[1]]
    return false
  end

  def get_piece_at square
    if square.instance_of?(Pawn)
      return "PAWN_#{square.colour}"
    end

    piece = @board[square[0].to_i][LETTERS_TO_INDEX[square[1]]]

    case piece
    when '-'
      return '-'
    when Pawn
      if piece.colour == "WHITE" then return "PAWN_WHITE" end
      return "PAWN_BLACK"
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

  def check_empty_or_enemy_square possible_moves, cur_square, colour
    piece = @board[cur_square[0].to_i][LETTERS_TO_INDEX[cur_square[1]]]
    if piece == '-'
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
      possible_moves = check_empty_or_enemy_square(possible_moves, cur_square, get_colour_at(from))
      break if decrement_both(cur_square) == cur_square
    end
    cur_square = from
    # 7A, 6B diagonal
    while cur_square[0].to_i <= 7 and LETTERS_TO_INDEX[cur_square[1]] >= 0
      cur_square = decrement_letters cur_square
      possible_moves = check_empty_or_enemy_square(possible_moves, cur_square, get_colour_at(from))
      break if decrement_letters(cur_square) == cur_square
    end
    cur_square = from
    # 7H, 6G diagonal
    while cur_square[0].to_i <= 7 and LETTERS_TO_INDEX[cur_square[1]] <= 7
      cur_square = increment_both cur_square
      possible_moves = check_empty_or_enemy_square(possible_moves, cur_square, get_colour_at(from))
      break if increment_both(cur_square) == cur_square
    end
    cur_square = from
    # 0H, 1G diagonal
    while cur_square[0].to_i >= 0 and LETTERS_TO_INDEX[cur_square[1]] <= 7
      cur_square = decrement_index cur_square
      possible_moves = check_empty_or_enemy_square(possible_moves, cur_square, get_colour_at(from))
      break if decrement_index(cur_square) == cur_square
    end

    top_left_square     =  (to[0].to_i - 1).to_s + (to[1].ord-1).chr
    top_right_square    =  (to[0].to_i - 1).to_s + (to[1].ord+1).chr
    bottom_left_square  =  (to[0].to_i + 1).to_s + (to[1].ord-1).chr
    bottom_right_square =  (to[0].to_i + 1).to_s + (to[1].ord+1).chr
    if possible_moves.include?(top_left_square) and get_colour_at(top_left_square) != get_colour_at(to)
      possible_moves.push to
    elsif possible_moves.include?(top_right_square) and get_colour_at(top_right_square) != get_colour_at(to)
      possible_moves.push to
    elsif possible_moves.include?(bottom_left_square) and get_colour_at(bottom_left_square) != get_colour_at(to)
      possible_moves.push to
    elsif possible_moves.include?(bottom_right_square) and get_colour_at(bottom_right_square) != get_colour_at(to)
      possible_moves.push to
    end
    return true if possible_moves.include?(to)
    return false
  end

  def valid_play_for_queen from, to
    return true if valid_play_for_rook(from, to) or valid_play_for_bishop(from, to)
    return false
  end

  def valid_play_for_pawn pawn, from, to
    return false if (get_piece_at to).include?(get_colour_at(from))

    if pawn.colour == "WHITE"
      if @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]].count == 0
        @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]].count  += 1
        return true if from[1] == to[1] and from[0].to_i + 2 == to[0].to_i
      end

      return false if not to[0].to_i > from[0].to_i
      return true  if to[0].to_i == from[0].to_i + 1 and to[1] == from[1]
      return true  if to[0].to_i == from[0].to_i + 1 and (to[1].ord + 1).chr == from[1] and get_colour_at(to) == "BLACK"
      return true  if to[0].to_i == from[0].to_i + 1 and (to[1].ord - 1).chr == from[1] and get_colour_at(to) == "BLACK"
      return false
    else
      if @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]].count == 0
        @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]].count  += 1
        return true if from[1] == to[1] and from[0].to_i - 2 == to[0].to_i
      end

      return false if not to[0].to_i < from[0].to_i
      return true  if to[0].to_i == from[0].to_i - 1 and to[1] == from[1]
      return true  if to[0].to_i == from[0].to_i - 1 and (to[1].ord + 1).chr == from[1] and get_colour_at(to) == "WHITE"
      return true  if to[0].to_i == from[0].to_i - 1 and (to[1].ord - 1).chr == from[1] and get_colour_at(to) == "WHITE"
      return false
    end
  end

  def has_checked square
    if get_colour_at(square) == "WHITE"
      cur_king = @king_black
    else
      cur_king = @king_white
    end

    piece = get_piece_at(square).split('_')[0]
    case piece
    when "BISHOP"
      return true if valid_play_for_bishop(square, cur_king)
      return false
    when "ROOK"
      return true if valid_play_for_rook(square, cur_king)
      return false
    when "KNIGHT"
      return true if valid_play_for_knight(square, cur_king)
      return false
    when "QUEEN"
      return true if valid_play_for_queen(square, cur_king)
      return false
    when "PAWN"
      return true if valid_play_for_pawn(@board[square[0].to_i][LETTERS_TO_INDEX[square[1]]], square, cur_king)
      return false
    end
  end

  
end
