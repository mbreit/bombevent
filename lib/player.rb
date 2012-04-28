require 'game_object'
require 'bomb'

class Player
  include GameObject

  SPEED = 0.2

  def initialize(game)
    self.game = game
    self.coordinates = game.next_spawn_position
  end

  def move(direction)
    new_coordinates = coordinates.dup
    case direction.to_sym
    when :up
      new_coordinates[1] = (new_coordinates[1] - SPEED).round(2)
    when :down
      new_coordinates[1] = (new_coordinates[1] + SPEED).round(2)
    when :left
      new_coordinates[0] = (new_coordinates[0] - SPEED).round(2)
    when :right
      new_coordinates[0] = (new_coordinates[0] + SPEED).round(2)
    end
    self.coordinates = new_coordinates if valid_coordinates?(*new_coordinates)
    send_position
  end

  def valid_coordinates?(x, y)
    (0..game.map_size[0]).include?(x) &&
      (0..game.map_size[1]).include?(y) &&
      !game.solid_object_at?(x,y)
  end

  def place_bomb
    bomb = Bomb.new(game, round_coordinates)
    bomb.add_to_game
    bomb.send_position
  end

  def solid?
    false
  end
end

