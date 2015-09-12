class Board
  ROWS, COLS = 6,7

  def clear_board
    Array.new(Board::COLS) { Array.new(Board::ROWS) }
  end
end

class Game
  PLAYERS = [:one, :two]
  EMPTYSPACE = "\u2609".encode('utf-8')
  DAY = "\u2600".encode('utf-8')
  SKULL = "\u2620".encode('utf-8')

  attr_reader :gameboard, :cur_player, :winner

  def initialize
    @board = Board.new
    @gameboard = @board.clear_board
    @winner = nil
    @cur_player = PLAYERS.first
  end

  def switch_player
    @cur_player = (@cur_player == PLAYERS.first) ? PLAYERS.last : PLAYERS.first
  end

  def valid_input? input
    return false if not input.is_a? Numeric
    return false if not input.between?(0, Board::COLS-1)
    return false if @gameboard[input].all?
    return true
  end

  def play column
    return unless valid_input? column
    if @cur_player == PLAYERS.first
      if not @gameboard[column].any?
        @gameboard[column][-1] = DAY
      else
        nils = @gameboard[column].count(nil)
        if nils == 0
          return
        elsif nils == 1
          @gameboard[column][0] = DAY
        else
          @gameboard[column][nils-1] = DAY
        end
      end
    else
      if not @gameboard[column].any?
        @gameboard[column][-1] = SKULL
      else
        nils = @gameboard[column].count(nil)
        if nils == 0
          return
        elsif nils == 1
          @gameboard[column][0] = SKULL
        else
          @gameboard[column][nils-1] = SKULL
        end
      end
    end
  end

  def print_board
    puts "0 1 2 3 4 5 6"
    Board::ROWS.times do |column|
      Board::COLS.times do |row|
        if not @gameboard[row][column]
          print EMPTYSPACE + " "
        else
          print @gameboard[row][column] + " "
        end
      end
      puts
    end
  end

  def start

    loop do
      puts "Enter column player #{cur_player} from 0 to #{Board::COLS-1}"
      played = false
      until played
        cur_play = gets.chomp.to_i
        if valid_input? cur_play
          column = cur_play
          played = true
        else
          puts "Sorry that is not a valid play"  
        end
      end
      play(column.to_i)
      switch_player
      print_board
      return "PLAYER ONE WINS" if check_victory == DAY
      return "PLAYER TWO WINS" if check_victory == SKULL
    end
  end

  def check_full_board
    @gameboard.each do |col|
      col.each do |row|
        if row == nil
          return false
        end
      end
    end
    return true
  end

  def check_victory
    # HORIZONTAL
    ocurrences = Array.new(Board::ROWS, "")
    @gameboard.each do |col|
      col.each_with_index do |row, index|
        if row == DAY
          ocurrences[index] += "D"
        elsif row == SKULL
          ocurrences[index] += "S"
        else
          ocurrences[index] += "E"
        end
      end
    end
    ocurrences.each do |ocurrence|
      if ocurrence.include? "SSSS"
        return SKULL
      elsif ocurrence.include? "DDDD"
        return DAY
      end
    end
    # VERTICAL
    Board::COLS.times do |col|
      Board::ROWS.times do |row|
        if @gameboard[col][row] != nil and @gameboard[col][row] == @gameboard[col][row+1] and @gameboard[col][row+1] == @gameboard[col][row+2] and @gameboard[col][row+2] == @gameboard[col][row+3]
          return @gameboard[col][row]
        end
      end
    end
    # TO THE RIGHT DIAGONAL
    cols = [0,1,2,3]
    rows = [3,2,1,0]
    add_value_cols = [0,1,2,3]
    add_value_rows = [0,1,2]
    add_value_rows.each do |value_row|
      rows_temp = rows.map { |n| n+value_row }
      add_value_cols.each do |value_col|
        cols_temp = cols.map { |n| n+value_col }
        if @gameboard[cols_temp[0]][rows_temp[0]] != nil and @gameboard[cols_temp[0]][rows_temp[0]] == @gameboard[cols_temp[1]][rows_temp[1]] and @gameboard[cols_temp[1]][rows_temp[1]] == @gameboard[cols_temp[2]][rows_temp[2]] and @gameboard[cols_temp[2]][rows_temp[2]] == @gameboard[cols_temp[3]][rows_temp[3]]
          return @gameboard[cols_temp[0]][rows_temp[0]]
        end
      end
    end
    # TO THE LEFT DIAGONAL
    cols = [0,1,2,3]
    rows = [0,1,2,3]
    add_value_cols = [0,1,2,3]
    add_value_rows = [0,1,2]
    add_value_rows.each do |value_row|
      rows_temp = rows.map { |n| n+value_row }
      add_value_cols.each do |value_col|
        cols_temp = cols.map { |n| n+value_col }
        if @gameboard[cols_temp[0]][rows_temp[0]] != nil and @gameboard[cols_temp[0]][rows_temp[0]] == @gameboard[cols_temp[1]][rows_temp[1]] and @gameboard[cols_temp[1]][rows_temp[1]] == @gameboard[cols_temp[2]][rows_temp[2]] and @gameboard[cols_temp[2]][rows_temp[2]] == @gameboard[cols_temp[3]][rows_temp[3]]
          return @gameboard[cols_temp[0]][rows_temp[0]]
        end
      end
    end
    return false
  end
end

game = Game.new
puts game.start if $DEBUG
