# frozen_string_literal: true

require './lib/settings'

Player = Struct.new(:id, :name)

class Game
  attr_reader :kills

  WORLD = 1022

  def initialize
    @score = {}
    @players = {}
    @kills = []
  end

  def total_kills
    @kills.count
  end

  def player_connect(player_id)
    player = Player.new(player_id)
    @players[player_id] = player
    @score[player_id] = 0
  end

  def player_disconnect(player_id)
    @players[player_id] = nil
    @score[player_id] = nil
  end

  def player_set_name(player_id, player_name)
    @players[player_id].name = player_name
  end

  def players
    @players.compact.values.map(&:name)
  end

  def kill(killer_id, killed_id, weapon_id)
    @kills << [killer_id, killed_id, weapon_id]

    if killer_id == WORLD || killer_id == killed_id
      @score[killed_id] -= 1
    else
      @score[killer_id] += 1
    end
  end

  def score
    data = @score.compact.transform_keys do |player_id|
      @players[player_id].name
    end
    data.sort_by { |_player, score| -score }.to_h
  end

  def kill_by_means
    kill_counter = @kills.each_with_object(Hash.new(0)) do |kill, counter|
      counter[kill[2]] += 1
      counter
    end

    kill_counter.transform_keys do |weapon_id|
      Settings::MEANS_OF_DEATH[weapon_id]
    end
  end
end
