# frozen_string_literal: true

require './lib/game'
require 'pry'

describe Game do
  subject(:game) { described_class.new }

  let(:player1) { instance_double(Player, id: 1, name: 'duke') }
  let(:player2) { instance_double(Player, id: 2, name: 'uriel') }

  describe '#start' do
    it { expect(game.score).to eq({}) }
    it { expect(game.kills).to eq([]) }
    it { expect(game.total_kills).to be(0) }
  end

  describe '#player_connect' do
    context 'when a player connects' do
      before { game.player_connect(1) }

      it { expect(game.players).to eq [nil] }

      context 'when a player sets its nickname' do
        before { game.player_set_name(1, 'duke') }

        it { expect(game.players).to eq ['duke'] }

        context 'when another player connects and sets its nickname' do
          before do
            game.player_connect(2)
            game.player_set_name(2, 'uriel')
          end

          it { expect(game.players).to eq %w[duke uriel] }
        end
      end
    end
  end

  describe '#player_kill' do
    before do
      [player1, player2].each do |player|
        game.player_connect(player.id)
        game.player_set_name(player.id, player.name)
      end
    end

    context 'when a player kills with a gun' do
      let(:weapon) { 'MOD_SHOTGUN' }

      before { game.kill(player1.id, player2.id, weapon) }

      it { expect(game.score).to eq({ player1.name => 1, player2.name => 0 }) }

      it { expect(game.total_kills).to eq(1) }
    end

    context 'when a player is killed by world' do
      let(:weapon) { 'MOD_TRIGGER_HURT' }

      before { game.kill(1022, player1.id, weapon) }

      it { expect(game.score).to eq({ player1.name => -1, player2.name => 0 }) }

      it { expect(game.total_kills).to eq(1) }
    end
  end

  describe '#kill_by_means' do
    before do
      [player1, player2].each do |id, name|
        game.player_connect(id)
        game.player_set_name(id, name)
      end

      1.upto(4) do |i|
        i.times { game.kill(player1, player2, i) }
      end
    end

    it do
      expect(game.kill_by_means).to eq(
        { MOD_SHOTGUN: 1, MOD_GAUNTLET: 2, MOD_MACHINEGUN: 3, MOD_GRENADE: 4 }
      )
    end
  end
end
