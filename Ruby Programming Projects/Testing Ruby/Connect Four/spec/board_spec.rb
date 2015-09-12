require_relative '../connect_four'

describe Board do
  let(:board) { Board.new }

  describe "#clear_board" do
    it "creates an empty board" do
      cleared_board = board.clear_board
      expect(cleared_board).to eq(Array.new(Board::COLS) { Array.new(Board::ROWS) })
    end
  end
end
