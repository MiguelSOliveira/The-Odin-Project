require_relative '../lib/game'

describe Game do
  let(:game) { Game.new }

  describe "#move_piece" do
    it "moves to and from the correct positions" do
      comparison_piece = game.board[6][Game::LETTERS_TO_INDEX['A']]
      game.move_piece("6A", "5A")
      expect(game.board[6][Game::LETTERS_TO_INDEX['A']]).to eq('-')
      expect(game.board[5][Game::LETTERS_TO_INDEX['A']]).to eq(comparison_piece)
    end
    it "does nothing if there is no piece at the desired square" do
      expect(game.move_piece("4A", "3A")).to be_falsey
    end
  end
  describe "#out_of_bounds" do
    it "does not move out of bounds" do
      expect(game.out_of_bounds("6A", "8A")).to be_truthy
      expect(game.out_of_bounds("6A", "6I")).to be_truthy
      expect(game.out_of_bounds("6A", "5A")).to be_falsey
    end
  end

  describe "#get_piece_at" do
    it "returns the name of the correct piece" do
      game.move_piece("6A", "5A")
      expect(game.get_piece_at("6A")).to eq("-")
      expect(game.get_piece_at("5A")).to eq("PAWN_BLACK")
      expect(game.get_piece_at("7H")).to eq("ROOK_BLACK")
      expect(game.get_piece_at("0E")).to eq("QUEEN_WHITE")
    end
  end
end
