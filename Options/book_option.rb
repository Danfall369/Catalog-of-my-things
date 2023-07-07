require_relative '../item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(publish_date, on_spotify)
    super(publish_date)
    @on_spotify = on_spotify
  end

  def add_book
    puts 'Enter Book Title:'
    title = gets.chomp

    puts 'Enter Published Date (YYYY-MM-DD):'
    publish_date = Date.parse(gets.chomp)

    puts 'Enter Cover State (good/bad):'
    cover_state = gets.chomp == 'good'

    puts 'Enter Publisher:'
    publisher = gets.chomp

    puts 'Enter Color:'
    color = gets.chomp

    book = Book.new(publish_date, title, publisher, color, cover_state)
    @books << book

    @storage.save_books(@books)

    label = Label.new(Random.rand(1..1000), title, color)
    label.add_item(book)
    @labels << label

    @storage.save_labels(@labels)

    puts 'Book Added Successfully!'
  end
end
