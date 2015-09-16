class Board
  COLS, ROWS = 8, 8
  attr_reader :board

  def clear_board
    @board = Array.new(ROWS) { Array.new(COLS) }
  end
end
