require_relative '../item'
require 'json'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state, :title, :color, :labels

  def initialize(publish_date, title, publisher, color, cover_state)
    super(publish_date)
    @title = title
    @publisher = publisher
    @color = color
    @cover_state = cover_state
    @can_be_archived = can_be_archived?
    @labels = []
  end

  def can_be_archived?
    return false if @publish_date.nil?

    (Time.now.year - @publish_date.year) > 10
  end

  def update_labels(labels)
    labels.each do |label|
      label.add_item(self) if label.title == @title
    end
  end
end
