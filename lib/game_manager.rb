# frozen_string_literal: true

require './lib/game'
require 'pry'

class GameManager
  attr_reader :game, :log_file

  def initialize(log_file)
    @log_file = log_file
    @game = Game.new
  end

  def parse
    File.foreach(log_file) do |line|
      read_line(line)
    end
  end

  def read_line(line)
    if (match = client_connect?(line))
      game.player_connect(match[:id])
    elsif (match = client_changed?(line))
      game.player_set_name(match[:id], match[:name])
    elsif (match = kill?(line))
      game.kill(match[:killer_id].to_i, match[:killed_id].to_i, match[:weapon_id].to_i)
    end
  end

  private

  def client_connect?(line)
    line.match(/\d+:\d+ ClientConnect: (?<id>\d+)/)
  end

  def client_changed?(line)
    line.match(/\d+:\d+ ClientUserinfoChanged: (?<id>\d+) n\\(?<name>.*?)\\t/)
  end

  def kill?(line)
    line.match(/\d+:\d+ Kill: (?<killer_id>\d+) (?<killed_id>\d+) (?<weapon_id>\d+):/)
  end
end
