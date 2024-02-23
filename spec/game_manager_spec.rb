# frozen_string_literal: true

require './lib/game_manager'

describe GameManager do
  subject(:game_manager) { described_class.new(log_file) }

  let(:log_file) { 'quake_test.log' }

  describe 'initialize' do
    it { expect(game_manager.game).to be_an_instance_of(Game) }
  end

  describe '#read_line' do
    let(:game) { game_manager.game }

    context 'when a player connects' do
      before do
        log_content.each { |line| game_manager.read_line(line) }
      end

      let(:log_content) do
        [
          '20:34 ClientConnect: 2',
          '20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0',
          '20:37 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0',
          '20:37 ClientBegin: 2'
        ]
      end

      it { expect(game.total_kills).to eq(0) }
      it { expect(game.score).to eq({ 'Isgalamido' => 0 }) }
      it { expect(game.kills).to eq([]) }
    end

    context 'when registering a kill' do
      let(:players) { [Player.new(3, 'Isgalamido'), Player.new(2, 'Dono da Bola')] }
      let(:log_content) do
        ['2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN']
      end

      before do
        players.each do |player|
          game.player_connect(player.id)
          game.player_set_name(player.id, player.name)
        end

        log_content.each { |line| game_manager.read_line(line) }
      end

      it { expect(game.total_kills).to eq(1) }
      it { expect(game.score).to eq({ 'Isgalamido' => 1, 'Dono da Bola' => 0 }) }
      it { expect(game.kills).to eq([[3, 2, 10]]) }
    end
  end
end
