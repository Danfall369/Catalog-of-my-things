require_relative '../item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state.to_s
  end

  def can_be_archived?
    return false if @publish_date.nil?

    (Time.now.year - @publish_date.year) > 10
  end
end
