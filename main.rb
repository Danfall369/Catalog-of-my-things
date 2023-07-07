# main.rb
require_relative './lib/book'

def print_options
  puts 'Options:'
  puts '1. List all books'
  puts '2. Add a book'
  puts '3. Move book to archived'
  puts '4. Quit'
end

def list_all_books
  # Implement the logic to list all books
  books = []
  if File.exist?(Book.file_path)
    book_data = File.read(Book.file_path)
    books = JSON.parse(book_data) unless book_data.empty?
  end

  if books.empty?
    puts 'No books available.'
  else
    books.each do |book|
      puts "ID: #{book['id']}"
      puts "Genre: #{book['genre']}"
      puts "Author: #{book['author']}"
      puts "Label: #{book['label']}"
      puts "Publish Date: #{book['publish_date']}"
      puts "Publisher: #{book['publisher']}"
      puts "Cover State: #{book['cover_state']}"
      puts "Archived: #{book['archived']}"
      puts '---'
    end
  end
end

def add_book
  # Implement the logic to add a book
  puts 'Enter the book details:'
  print 'ID: '
  id = gets.chomp
  print 'Genre: '
  genre = gets.chomp
  print 'Author: '
  author = gets.chomp
  print 'Label: '
  label = gets.chomp
  print 'Publish Date (YYYY-MM-DD): '
  publish_date = Date.parse(gets.chomp)
  print 'Publisher: '
  publisher = gets.chomp
  print 'Cover State (good/bad): '
  cover_state = gets.chomp

  book = Book.new(id, genre, author, label, publish_date, publisher, cover_state)
  book.save
  puts 'Book added successfully.'
end

def move_to_archived
  # Implement the logic to move a book to archived
  puts 'Enter the ID of the book to move to archived:'
  id = gets.chomp

  books = []
  if File.exist?(Book.file_path)
    book_data = File.read(Book.file_path)
    books = JSON.parse(book_data) unless book_data.empty?
  end

  book = books.find { |b| b['id'] == id }

  if book.nil?
    puts 'Book not found.'
  else
    book['archived'] = true
    File.open(Book.file_path, 'w') do |file|
      file.write(JSON.generate(books))
    end
    puts 'Book moved to archived.'
  end
end

loop do
  print_options
  option = gets.chomp.to_i

  case option
  when 1
    list_all_books
  when 2
    add_book
  when 3
    move_to_archived
  when 4
    puts 'Exiting the app. Goodbye!'
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
