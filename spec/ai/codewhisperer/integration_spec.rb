# spec/integration/game_manager_integration_spec.rb
require './lib/game_manager'

RSpec.describe 'Integration Test' do
  let(:log_files) do
    {
      'game2.log' => {
        total_kills: 11,
        players: ['Isgalamido'],
        kills: { 'Isgalamido' => -7 },
        kill_by_means: {
          MOD_TRIGGER_HURT: 7,
          MOD_ROCKET_SPLASH: 3,
          MOD_FALLING: 1
        }
      },
      'game5.log' => {
        total_kills: 14,
        players: [],
        kills: {},
        kill_by_means: {
          MOD_ROCKET: 4,
          MOD_ROCKET_SPLASH: 4,
          MOD_TRIGGER_HURT: 5,
          MOD_RAILGUN: 1
        }
      },
      'game7.log' => {
        total_kills: 130,
        players: ['Oootsimo', 'Isgalamido', 'Zeh', 'Dono da Bola', 'Mal', 'Assasinu Credi'],
        kills: {
          'Oootsimo' => 20,
          'Assasinu Credi' => 16,
          'Isgalamido' => 12,
          'Dono da Bola' => 8,
          'Zeh' => 7,
          'Mal' => -3
        },
        kill_by_means: {
          MOD_FALLING: 7,
          MOD_TRIGGER_HURT: 20,
          MOD_ROCKET: 29,
          MOD_RAILGUN: 9,
          MOD_ROCKET_SPLASH: 49,
          MOD_SHOTGUN: 7,
          MOD_MACHINEGUN: 9
        }
      }
    }
  end

  it 'parses the log files and validates the game reports' do
    log_files.each do |log_file, expected_report|
      game_manager = GameManager.new("spec/fixtures/#{log_file}")
      game_manager.parse

      expect(game_manager.report).to have_key("game_1")
      report = game_manager.report["game_1"]

      expect(report[:total_kills]).to eq(expected_report[:total_kills])
      expect(report[:players]).to match_array(expected_report[:players])
      expect(report[:kills]).to eq(expected_report[:kills])
      expect(report[:kill_by_means]).to eq(expected_report[:kill_by_means])
    end
  end
end

