require_relative 'board'

class Game < Board
  PLAYER = [:WHITE, :BLACK]
  attr_reader :cur_player

  def initialize
    @cur_player = PLAYER[0]
    super
  end

  def move_piece from, to
    return false if @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] == '-' or out_of_bounds(from, to)

    @board[to[0].to_i][LETTERS_TO_INDEX[to[1]]] = @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]]
    @board[from[0].to_i][LETTERS_TO_INDEX[from[1]]] = '-'
    @white_king = to if get_piece_at(to) == "KING_WHITE"
    @black_king = to if get_piece_at(to) == "KING_BLACK"
    return true
  end

  def play
    check_mate = false
    until check_mate
      print_board
      played = false
      until played
        print "Enter play #{@cur_player}: "
        entered_play = gets.chomp.split
        if out_of_bounds(entered_play[0], entered_play[1])
          puts "My board is up here, mate"
          next
        end
        piece = get_piece_at(entered_play[0])
        if not piece.include?(@cur_player.to_s) and piece != '-'
          puts "Not your piece, try again."
          next
        end
        case piece.split('_')[0]
        when '-'
          puts "Invalid play, try again."
        when 'BISHOP'
         if valid_play_for_bishop(entered_play[0], entered_play[1]) then move_piece(entered_play[0], entered_play[1]) and played = true else puts "Invalid play, try again." end
        when 'ROOK'
          if valid_play_for_rook(entered_play[0], entered_play[1]) then move_piece(entered_play[0], entered_play[1]) and played = true else puts "Invalid play, try again." end
        when 'KNIGHT'
          if valid_play_for_knight(entered_play[0], entered_play[1]) then move_piece(entered_play[0], entered_play[1]) and played = true else puts "Invalid play, try again." end
        when 'QUEEN'
          if valid_play_for_queen(entered_play[0], entered_play[1]) then move_piece(entered_play[0], entered_play[1]) and played = true else puts "Invalid play, try again." end
        when 'KING'
          if valid_play_for_king(entered_play[0], entered_play[1]) then move_piece(entered_play[0], entered_play[1]) and played = true else puts "Invalid play, try again." end
        when 'PAWN'
          move_piece(entered_play[0], entered_play[1]) and played = true if valid_play_for_pawn(@board[entered_play[0][0].to_i][LETTERS_TO_INDEX[entered_play[0][1]]], entered_play[0], entered_play[1])
        end
      end
      puts "CHECK BY #{@cur_player}" if has_checked(entered_play[1])
      puts "CHECK MATE BY #{@cur_player}" and break if has_mated(@cur_player.to_s)
      switch_player
    end
  end

  def switch_player
    @cur_player = (@cur_player == :WHITE) ? :BLACK : :WHITE
  end
end

g = Game.new
g.play
