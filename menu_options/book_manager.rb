require './methods/genre'
require './methods/author'
require './methods/label'
require './methods/book'
require 'json'

class BookOptions
  attr_accessor :books

  def initialize(books)
    @books = books
  end

  def list_books(books)
    puts 'List of Books:'
    if books.empty?
      puts 'No books added yet'
    else
      books.each do |book|
        puts ''
        puts "----- Book number #{book.id} -----"
        puts "Book Name: #{book.label.title}"
        puts "Author: #{book.author.first_name} #{book.author.last_name}"
        puts "Published by: #{book.publisher} on: #{book.publish_date}"
        puts "Genre: #{book.genre.name}"
        puts "Color: #{book.label.color}"
        puts ''
      end
    end
  end

  def add_book
    puts '--- Add a Book ---'
    puts 'Please, fill the required information'
    print 'Book title: '
    label_title = gets.chomp

    print 'Book genre: '
    genre_name = gets.chomp
    genre = Genre.new(genre_name)

    print 'Book author first name: '
    author_first_name = gets.chomp

    print 'Book author last name: '
    author_last_name = gets.chomp
    author = Author.new(author_first_name, author_last_name)

    print 'Enter the label color: '
    label_color = gets.chomp
    label = Label.new(Random.rand(1..1000), label_title, label_color)

    print 'Enter Published Date (YYYY-MM-DD): '
    begin
      publish_date = Date.strptime(gets.chomp, '%Y-%m-%d')
    rescue ArgumentError
      puts ''
      puts '-------------------------------------------------------------------------------------'
      puts 'Invalid date!'
      puts '-------------------------------------------------------------------------------------'
      return
    end

    print 'Enter Cover State (Good/Bad): '
    cover_state = gets.chomp

    print 'Enter Book Publisher: '
    publisher = gets.chomp

    book = Book.new(publish_date, publisher, cover_state)

    # puts the book "book title" has been added
    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts "The book: #{label_title}, by: #{author.first_name} #{author.last_name}, has been added"
    puts '-------------------------------------------------------------------------------------'

    genre.add_item(book)
    author.add_item(book)
    label.add_item(book)
    @books << book
  end

  def save_books
    books_data = []
    @books.each do |book|
      books_data.push(
        publish_date: book.publish_date,
        genre: book.genre.name,
        label_title: book.label.title,
        label_color: book.label.color,
        author_first_name: book.author.first_name,
        author_last_name: book.author.last_name,
        publisher: book.publisher,
        cover_state: book.cover_state
      )
    end
    File.write('data/books.json', books_data.to_json)
  end

  def load_books
    return unless File.exist?('Storage/books.json')

    books_data = JSON.parse(File.read('Storage/books.json'))
    books_data.each do |book_data|
      book_genre = Genre.new(book_data['genre'])
      book_label = Label.new(Random.rand(1..1000), book_data['label_title'], book_data['label_color'])
      book_author = Author.new(book_data['author_first_name'], book_data['author_last_name'])
      book = Book.new(book_data['publish_date'], book_data['publisher'], book_data['cover_state'])
      book_genre.add_item(book)
      book_label.add_item(book)
      book_author.add_item(book)
      @books << book
    end
  end
end
