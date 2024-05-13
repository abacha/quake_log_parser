# spec/game_spec.rb
require './lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'initializes the game with empty score, players, and kills' do
      expect(game.instance_variable_get(:@score)).to eq({})
      expect(game.instance_variable_get(:@players)).to eq({})
      expect(game.instance_variable_get(:@kills)).to eq([])
    end
  end

  describe '#total_kills' do
    it 'returns the total number of kills' do
      game.instance_variable_get(:@kills).push([1, 2, 3], [4, 5, 6])
      expect(game.total_kills).to eq(2)
    end
  end

  describe '#player_connect' do
    it 'adds a new player to the game' do
      game.player_connect(1)
      expect(game.instance_variable_get(:@players)[1]).to be_a(Player)
      expect(game.instance_variable_get(:@score)[1]).to eq(0)
    end
  end

  describe '#player_disconnect' do
    it 'removes a player from the game' do
      game.player_connect(1)
      game.player_disconnect(1)
      expect(game.instance_variable_get(:@players)[1]).to be_nil
      expect(game.instance_variable_get(:@score)[1]).to be_nil
    end
  end

  describe '#player_set_name' do
    it 'sets the name of a player' do
      game.player_connect(1)
      game.player_set_name(1, 'John Doe')
      expect(game.instance_variable_get(:@players)[1].name).to eq('John Doe')
    end
  end

  describe '#players' do
    it 'returns a list of all player names' do
      game.player_connect(1)
      game.player_set_name(1, 'John Doe')
      game.player_connect(2)
      game.player_set_name(2, 'Jane Smith')
      expect(game.players).to eq(['John Doe', 'Jane Smith'])
    end
  end

  describe '#kill' do
    it 'records a kill and updates the score' do
      game.player_connect(1)
      game.player_connect(2)
      game.kill(1, 2, 3)
      expect(game.instance_variable_get(:@kills)).to eq([[1, 2, 3]])
      expect(game.instance_variable_get(:@score)[1]).to eq(1)
      expect(game.instance_variable_get(:@score)[2]).to eq(-1)
    end
  end

  describe '#score' do
    it 'returns the score sorted by highest to lowest' do
      game.player_connect(1)
      game.player_set_name(1, 'John Doe')
      game.player_connect(2)
      game.player_set_name(2, 'Jane Smith')
      game.kill(1, 2, 3)
      game.kill(1, 2, 3)
      expect(game.score).to eq({ 'John Doe' => 2, 'Jane Smith' => -2 })
    end
  end

  describe '#kill_by_means' do
    it 'returns a hash of kills by weapon' do
      game.kill(1, 2, 3)
      game.kill(2, 1, 4)
      game.kill(1, 2, 3)
      expect(game.kill_by_means).to eq({ 'Railgun' => 2, 'Rocket Launcher' => 1 })
    end
  end
end
