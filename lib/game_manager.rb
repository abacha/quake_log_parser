# frozen_string_literal: true

require './lib/game'

class GameManager
  attr_reader :log_file, :report

  def initialize(log_file)
    @log_file = log_file
    @games = []
    @report = {}
  end

  def game
    @games.last
  end

  def parse
    File.foreach(log_file) do |line|
      read_line(line)
    end
  end

  def read_line(line)
    if new_game?(line)
      new_game
    elsif end_game?(line)
      end_game
    elsif (match = client_connect?(line))
      handle_client_connect(match)
    elsif (match = client_disconnect?(line))
      handle_client_disconnect(match)
    elsif (match = client_changed?(line))
      handle_client_changed(match)
    elsif (match = kill?(line))
      handle_kill(match)
    end
  end

  def new_game
    @games << Game.new
  end

  def end_game
    @report["game_#{@games.size}"] =
      {
        total_kills: game.total_kills,
        players: game.players,
        kills: game.score,
        kill_by_means: game.kill_by_means
      }
  end

  private

  def new_game?(line)
    line.match(/\d+:\d+ InitGame:/)
  end

  def end_game?(line)
    line.match?(/ShutdownGame:/)
  end

  def client_connect?(line)
    line.match(/\d+:\d+ ClientConnect: (?<player_id>\d+)/)
  end

  def client_disconnect?(line)
    line.match(/\d+:\d+ ClientDisconnect: (?<player_id>\d+)/)
  end

  def client_changed?(line)
    line.match(/\d+:\d+ ClientUserinfoChanged: (?<player_id>\d+) n\\(?<name>.*?)\\t/)
  end

  def kill?(line)
    line.match(/\d+:\d+ Kill: (?<killer_id>\d+) (?<killed_id>\d+) (?<weapon_id>\d+):/)
  end

  def handle_client_connect(match)
    game.player_connect(match[:player_id].to_i)
  end

  def handle_client_disconnect(match)
    game.player_disconnect(match[:player_id].to_i)
  end

  def handle_client_changed(match)
    game.player_set_name(match[:player_id].to_i, match[:name])
  end

  def handle_kill(match)
    game.kill(match[:killer_id].to_i, match[:killed_id].to_i, match[:weapon_id].to_i)
  end
end
