require 'json'
require_relative 'methods/book'
require_relative 'methods/label'

class Storage
  def initialize(genres)
    @genres = genres
  end

  def save_books(books)
    book_data = books.map do |book|
      genre_name = book.genre ? book.genre.name : 'N/A'
      {
        'title' => book.title,
        'publish_date' => book.publish_date.to_s,
        'publisher' => book.publisher,
        'color' => book.color,
        'cover_state' => book.cover_state,
        'archived' => book.archived,
        'genre' => genre_name
      }
    end
    File.write('data/books.json', JSON.pretty_generate(book_data))
  end

  def save_labels(labels)
    label_data = labels.map do |label|
      {
        'id' => label.id,
        'title' => label.title,
        'color' => label.color
      }
    end

    File.write('data/labels.json', JSON.pretty_generate(label_data))
  end

  def load_books
    if File.exist?('data/books.json')
      json_data = JSON.parse(File.read('data/books.json'))
      json_data.map do |data|
        publish_date = data['publish_date'] ? Date.parse(data['publish_date']) : nil
        genre_name = data['genre']
        genre = genre_name ? Genre.new(genre_name) : nil
        book = Book.new(publish_date, data['title'], data['publisher'], data['color'], data['cover_state'])
        book.archived = data['archived']
        book.genre = genre
        book
      end
    else
      []
    end
  end

  def load_labels
    if File.exist?('data/labels.json')
      json_data = File.read('data/labels.json')
      if json_data.empty?
        []
      else
        begin
          JSON.parse(json_data).map do |data|
            Label.new(data['id'], data['title'], data['color'])
          end
        rescue JSON::ParserError => e
          puts "Error parsing JSON data: #{e.message}"
          []
        end
      end
    else
      []
    end
  end
end

genres = []

Storage.new(genres)