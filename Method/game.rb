require_relative '../item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    years_since_last_played = Time.now.year - Date.parse(@last_played_at).year > 2
    super && years_since_last_played
  end
end
