require_relative '../lib/chess_game'

describe Game do
  let(:game) { Game.new }

  describe "#play" do
    it "plays and switches in the correct place" do
      expect(game.board[2][0]).to eq('-')
      expect(game.board[0][0]).to eq(Game::ROOK_WHITE)
      game.play("0A", "2A")
      expect(game.board[0][0]).to eq('-')
      expect(game.board[2][0]).to eq(Game::ROOK_WHITE)
    end
  end

  describe "#switch_player" do
    it "switches player" do
      expect(game.cur_player).to eq(Game::PLAYER[0])
      game.switch_player
      expect(game.cur_player).to eq(Game::PLAYER[1])
    end
  end
end
