require './item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(publish_date, on_spotify)
    super(publish_date)
    @publish_date = publish_date
    @on_spotify = on_spotify
  end

  def can_be_archived?
    return false unless super and @on_spotify

    @archived = true
  end
end
