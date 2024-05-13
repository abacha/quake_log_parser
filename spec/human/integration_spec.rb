# frozen_string_literal: true

require './lib/game_manager'

describe 'Integration' do
  shared_examples 'game' do
    subject(:game_manager) { GameManager.new(game_log) }

    before { game_manager.parse }

    let(:report) do
      {
        total_kills: total_kills,
        players: players,
        kills: kills,
        kill_by_means: kill_by_means
      }
    end

    it { expect(game_manager.report['game_1']).to eq(report) }
  end

  context 'with game2' do
    let(:game_log) { 'spec/fixtures/game2.log' }
    let(:total_kills) { 11 }
    let(:players) { %w[Isgalamido] }
    let(:kills) { { 'Isgalamido' => -7 } }
    let(:kill_by_means) do
      {
        MOD_TRIGGER_HURT: 7,
        MOD_ROCKET_SPLASH: 3,
        MOD_FALLING: 1
      }
    end

    it_behaves_like 'game'
  end

  context 'with game5' do
    let(:game_log) { 'spec/fixtures/game5.log' }
    let(:total_kills) { 14 }
    let(:players) { [] }
    let(:kills) { {} }
    let(:kill_by_means) do
      {
        MOD_ROCKET: 4,
        MOD_ROCKET_SPLASH: 4,
        MOD_TRIGGER_HURT: 5,
        MOD_RAILGUN: 1
      }
    end

    it_behaves_like 'game'
  end

  context 'with game7' do
    let(:game_log) { 'spec/fixtures/game7.log' }
    let(:total_kills) { 130 }
    let(:players) { ['Oootsimo', 'Isgalamido', 'Zeh', 'Dono da Bola', 'Mal', 'Assasinu Credi'] }
    let(:kills) do
      {
        'Oootsimo' => 20,
        'Assasinu Credi' => 16,
        'Isgalamido' => 12,
        'Dono da Bola' => 8,
        'Zeh' => 7,
        'Mal' => -3
      }
    end
    let(:kill_by_means) do
      {
        MOD_FALLING: 7,
        MOD_TRIGGER_HURT: 20,
        MOD_ROCKET: 29,
        MOD_RAILGUN: 9,
        MOD_ROCKET_SPLASH: 49,
        MOD_SHOTGUN: 7,
        MOD_MACHINEGUN: 9
      }
    end

    it_behaves_like 'game'
  end
end
