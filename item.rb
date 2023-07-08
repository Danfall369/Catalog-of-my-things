require 'date'
require_relative 'methods/label'

class Item
  attr_accessor :id, :author, :genre, :source, :label, :publish_date, :archived

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    date = Date.new(@publish_date.to_i)
    (Date.today - date).to_i > 3650
  end

  def move_to_archive
    if can_be_archived? == true
      @archived = true
    else
      puts 'This item cannot be archived'
    end
  end

  def genre=(genre)
    if genre.is_a?(Genre)
      @genre = genre
      genre.items << self
    else
      puts 'Invalid genre'
    end
  end

  def label=(label)
    if label.is_a?(Label)
      @label = label
      label.items << self
    else
      puts 'Invalid label'
    end
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end
end
