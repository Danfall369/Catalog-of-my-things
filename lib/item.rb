require 'date'
require_relative 'Method/genre'
require_relative 'Method/label'

class Item
  attr_reader :id, :genre, :author, :label, :publish_date
  attr_accessor :archived

  def initialize(id, genre, author, label, publish_date)
    @id = id
    @genre = genre
    @author = author
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    (Time.now.year - publish_date.year) > 10
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
