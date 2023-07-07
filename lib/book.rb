# book.rb
require_relative 'item'
require 'json'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(id, genre, author, label, publish_date, publisher, cover_state)
    super(id, genre, author, label, publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end

  def move_to_archived
    if can_be_archived?
      @archived = true
      puts 'Item moved to archived.'
    else
      puts 'Item cannot be archived.'
    end
  end

  def save
    book_data = {
      id: id,
      genre: genre,
      author: author,
      label: label,
      publish_date: publish_date.to_s,
      publisher: publisher,
      cover_state: cover_state,
      archived: archived
    }

    books = []

    if File.exist?(self.class.file_path)
      existing_data = File.read(self.class.file_path)
      books = JSON.parse(existing_data) unless existing_data.empty?
    end

    books << book_data

    File.open(self.class.file_path, 'w') do |file|
      file.write(JSON.generate(books))
    end
  end

  def self.file_path
    './data/book.json'
  end
end
