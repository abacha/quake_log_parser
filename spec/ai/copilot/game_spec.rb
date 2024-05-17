require './lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#total_kills' do
    it 'returns the total number of kills' do
      expect(game.total_kills).to eq(0)
    end
  end

  describe '#player_connect' do
    it 'adds a new player to the game' do
      game.player_connect(1)
      expect(game.players).to include(1)
    end
  end

  describe '#player_disconnect' do
    it 'removes a player from the game' do
      game.player_connect(1)
      game.player_disconnect(1)
      expect(game.players).not_to include(1)
    end
  end

  describe '#player_set_name' do
    it 'sets the name of a player' do
      game.player_connect(1)
      game.player_set_name(1, 'John')
      expect(game.players).to include('John')
    end
  end

  describe '#kill' do
    it 'records a kill' do
      game.player_connect(1)
      game.player_connect(2)
      game.kill(1, 2, 1)
      expect(game.total_kills).to eq(1)
    end

    it 'updates the score' do
      game.player_connect(1)
      game.player_connect(2)
      game.kill(1, 2, 1)
      expect(game.score['John']).to eq(1)
      expect(game.score['Unknown']).to eq(-1)
    end
  end

  describe '#score' do
    it 'returns the score of each player' do
      game.player_connect(1)
      game.player_connect(2)
      game.kill(1, 2, 1)
      expect(game.score).to eq({ 'John' => 1, 'Unknown' => -1 })
    end
  end

  describe '#kill_by_means' do
    it 'returns the number of kills by means of death' do
      game.player_connect(1)
      game.player_connect(2)
      game.kill(1, 2, 1)
      expect(game.kill_by_means).to eq({ 'MOD_UNKNOWN' => 1 })
    end
  end
end