require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(id, genre, author, label, publish_date, publisher, cover_state)
    super(id, genre, author, label, publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == "bad"
  end

  def move_to_archived
    if can_be_archived?
      @archived = true
      puts 'Item moved to archived.'
    else
      puts 'Item cannot be archived.'
    end
  end
end
