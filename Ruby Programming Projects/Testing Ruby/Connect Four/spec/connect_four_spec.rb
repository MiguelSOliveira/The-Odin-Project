require_relative '../connect_four'

describe Game do
  let(:game) { Game.new }
  let(:player1) { Game::PLAYERS.first }
  let(:player2) { Game::PLAYERS.last }

  before(:each) do
    allow(game).to receive(:puts)
    allow(game).to receive(:print)
  end

  describe "#new" do
    it "creates an instance of Game" do
      expect(game).to be_instance_of(Game)
    end
    it "sets winner to nil" do
      expect(game.winner).to be_nil
    end
    it "sets initial player to first player" do
      expect(game.cur_player).to eq(player1)
    end
  end

  describe "#switch_player" do
    it "switches from player1 to player2" do
      expect(game.cur_player).to eq(player1)
      game.switch_player
      expect(game.cur_player).to eq(player2)
    end
    it "switches from player2 to player1" do
      game.switch_player
      expect(game.cur_player).to eq(player2)
      game.switch_player
      expect(game.cur_player).to eq(player1)
    end
  end

  describe "#valid_input?" do
    it "rejects non-numeric input" do
      expect(game.valid_input?("String")).to be_falsey
    end
    it "accepts numeric values" do
      expect(game.valid_input?(1)).to be_truthy
    end
    it "rejects negative numbers" do
      expect(game.valid_input?(-1)).to be_falsey
    end
    it "rejects values outside column limits" do
      expect(game.valid_input?(8)).to be_falsey
    end
    it "doesnt allow more plays on a full collumn" do
      Board::COLS.times { game.gameboard[0].push(1) and game.gameboard[0].shift }
      expect(game.valid_input?(0)).to be_falsey
    end
  end

  describe "#play" do
    it "plays in the right column" do
      size = game.gameboard[0].count(nil)
      game.play(0)
      expect(game.gameboard[0].count(nil)).to eq(size-1)
    end
  end

  describe "#check_victory" do
    it "can win horizontally at row begin" do
      sequence = [0,0,1,0,2,0,3]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::DAY)
    end
    it "can win horizontally at row end" do
      sequence = [3,3,4,4,5,5,6]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::DAY)
    end
    it "can win horizontally at any row" do
      sequence = [3,3,4,4,5,5,5,6,5,6]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::SKULL)
    end
    it "can win vertically at columns begin" do
      sequence = [0,1,0,1,0,1,0]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::DAY)
    end
    it "can win vertically at columns end" do
      sequence = [6,5,6,5,6,5,6]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::DAY)
    end
    it "wins at diagonals pointing to the right at begin" do
      sequence = [0,1,1,2,3,2,2,3,3,4,3]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::DAY)
    end
    it "wins at diagonals pointing to the right at end" do
      sequence = [6,6,6,6,5,5,4,5,2,3,3,4]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::SKULL)
    end
    it "wins at diagonals pointing to the left at begin" do
      sequence = [0,0,0,0,0,0,1,1,1,1,2,1,2,2,4,2,4,3,3,3]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::SKULL)
    end
    it "wins at diagonals pointing to the left at end" do
      sequence = [6,6,6,6,5,3,5,5,4,4]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_victory).to eq(Game::SKULL)
    end
  end

  describe "#check_full_board" do
    it "returns true if board is full" do
      sequence = [0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,4,3,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_full_board).to be_truthy
    end
    it "returns false if board is not full" do
      sequence = [0]
      sequence.each do |digit|
        game.play(digit)
        game.switch_player
      end
      expect(game.check_full_board).to_not be_truthy
    end
  end
end
