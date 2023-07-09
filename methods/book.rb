require './item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state.to_s
  end

  def can_be_archived?
    return false if publish_date.nil?

    years_since_publish = Date.today.year - publish_date.year
    if years_since_publish > 10
      true
    else
      @cover_state.downcase == 'bad'
    end
  end
end
