# spec/game_manager_spec.rb
require './lib/game_manager'
require './lib/game'

RSpec.describe GameManager do
  let(:log_file) { 'spec/fixtures/quake_log.txt' }
  let(:game_manager) { GameManager.new(log_file) }

  describe '#initialize' do
    it 'initializes the GameManager with the log file and empty games and report' do
      expect(game_manager.log_file).to eq(log_file)
      expect(game_manager.instance_variable_get(:@games)).to be_empty
      expect(game_manager.report).to eq({})
    end
  end

  describe '#game' do
    it 'returns the last game in the games array' do
      game_manager.instance_variable_get(:@games) << Game.new
      expect(game_manager.game).to be_a(Game)
    end
  end

  describe '#parse' do
    it 'reads and processes each line in the log file' do
      expect(game_manager).to receive(:read_line).exactly(10).times
      game_manager.parse
    end
  end

  describe '#read_line' do
    it 'handles different types of log lines' do
      expect(game_manager).to receive(:new_game).once
      expect(game_manager).to receive(:end_game).once
      expect(game_manager).to receive(:handle_client_connect).once
      expect(game_manager).to receive(:handle_client_disconnect).once
      expect(game_manager).to receive(:handle_client_changed).once
      expect(game_manager).to receive(:handle_kill).once

      game_manager.read_line('1:23 InitGame:')
      game_manager.read_line('2:45 ShutdownGame:')
      game_manager.read_line('3:12 ClientConnect: 1')
      game_manager.read_line('4:34 ClientDisconnect: 1')
      game_manager.read_line('5:56 ClientUserinfoChanged: 1 n\John Doe\t')
      game_manager.read_line('6:78 Kill: 1 2 3:')
    end
  end

  describe '#new_game' do
    it 'creates a new game and adds it to the games array' do
      expect { game_manager.new_game }.to change { game_manager.instance_variable_get(:@games).count }.by(1)
      expect(game_manager.instance_variable_get(:@games).last).to be_a(Game)
    end
  end

  describe '#end_game' do
    it 'adds the game report to the report hash' do
      game_manager.instance_variable_get(:@games) << Game.new
      expect { game_manager.end_game }.to change { game_manager.report.count }.by(1)
      expect(game_manager.report).to have_key("game_1")
    end
  end

  describe 'private methods' do
    describe '#new_game?' do
      it 'returns true for lines that start a new game' do
        expect(game_manager.send(:new_game?, '1:23 InitGame:')).to be true
        expect(game_manager.send(:new_game?, '2:45 ShutdownGame:')).to be false
      end
    end

    describe '#end_game?' do
      it 'returns true for lines that end a game' do
        expect(game_manager.send(:end_game?, '2:45 ShutdownGame:')).to be true
        expect(game_manager.send(:end_game?, '1:23 InitGame:')).to be false
      end
    end

    describe '#client_connect?' do
      it 'returns a match for lines that indicate a client connection' do
        match = game_manager.send(:client_connect?, '3:12 ClientConnect: 1')
        expect(match[:player_id]).to eq('1')
      end
    end

    describe '#client_disconnect?' do
      it 'returns a match for lines that indicate a client disconnection' do
        match = game_manager.send(:client_disconnect?, '4:34 ClientDisconnect: 1')
        expect(match[:player_id]).to eq('1')
      end
    end

    describe '#client_changed?' do
      it 'returns a match for lines that indicate a client name change' do
        match = game_manager.send(:client_changed?, '5:56 ClientUserinfoChanged: 1 n\John Doe\t')
        expect(match[:player_id]).to eq('1')
        expect(match[:name]).to eq('John Doe')
      end
    end

    describe '#kill?' do
      it 'returns a match for lines that indicate a kill' do
        match = game_manager.send(:kill?, '6:78 Kill: 1 2 3:')
        expect(match[:killer_id]).to eq('1')
        expect(match[:killed_id]).to eq('2')
        expect(match[:weapon_id]).to eq('3')
      end
    end
  end
end
