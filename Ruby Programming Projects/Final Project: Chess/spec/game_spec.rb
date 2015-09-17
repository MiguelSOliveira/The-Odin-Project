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

  describe "#valid_play_for_pawn?" do
    it "moves one space" do
      pawn = Game::PAWN_WHITE
      expect(game.valid_play_for_pawn?(pawn, "1A", "2A")).to be_truthy
    end
    it "moves two spaces on the first play" do
      pawn = Game::PAWN_WHITE
      pawn.count = 0
      expect(game.valid_play_for_pawn?(pawn, "1A", "3A")).to be_truthy
    end
    it "does not move more than one space vertically on the second play" do
      pawn = Game::PAWN_WHITE
      pawn.count = 0
      game.play("1A", "2A")
      pawn.count = 1
      game.switch_player
      game.play("6A", "5A")
      game.switch_player
      expect(game.valid_play_for_pawn?(pawn, "2A", "4A")).to be_falsey
    end
    it "does not move backwards" do
      pawn = Game::PAWN_WHITE
      pawn.count = 0
      expect(game.valid_play_for_pawn?(pawn, "2A", "1A")).to be_falsey
    end
  end
end
