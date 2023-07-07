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
