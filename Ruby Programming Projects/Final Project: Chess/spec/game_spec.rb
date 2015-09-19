require_relative '../lib/game'

describe Game do
  let(:game) { Game.new }

  describe "#move_piece" do
    it "moves to and from the correct positions" do
      comparison_piece = game.board[6][Game::LETTERS_TO_INDEX['A']]
      game.move_piece("6A", "2B")
      expect(game.board[6][Game::LETTERS_TO_INDEX['A']]).to eq('-')
      expect(game.board[2][Game::LETTERS_TO_INDEX['B']]).to eq(comparison_piece)
    end
    it "does nothing if there is no piece at the desired square" do
      expect(game.move_piece("4A", "3A")).to be_falsey
    end
  end
end
