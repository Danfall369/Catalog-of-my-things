require_relative 'lib/book'
require_relative 'lib/label'
require 'date'

def print_options
  puts 'Options:'
  puts '1. List all books'
  puts '2. List all labels'
  puts '3. Add a book'
  puts '4. Quit'
end

def list_all_books
  books = Book.load_from_file

  if books.empty?
    puts 'No books available.'
  else
    books.each do |book|
      puts "ID: #{book.id}"
      puts "Genre: #{book.genre}"
      puts "Author: #{book.author}"
      puts "Label: #{book.label}"
      puts "Publish Date: #{book.publish_date}"
      puts "Publisher: #{book.publisher}"
      puts "Cover State: #{book.cover_state}"
      puts "Archived: #{book.archived}"
      puts '---'
    end
  end
end

def list_all_labels
  labels = Label.load_from_file

  if labels.empty?
    puts 'No labels available.'
  else
    labels.each do |label|
      puts "ID: #{label.id}"
      puts "Title: #{label.title}"
      puts "Color: #{label.color}"
      puts '---'
    end
  end
end

def add_book
  puts 'Enter the book details:'
  print 'ID: '
  id = gets.chomp
  print 'Genre: '
  genre = gets.chomp
  print 'Author: '
  author = gets.chomp
  print 'Label: '
  label_title = gets.chomp
  publish_date = input_publish_date
  print 'Publisher: '
  publisher = gets.chomp
  print 'Cover State (good/bad): '
  cover_state = gets.chomp

  book = Book.new(
    id: id,
    genre: genre,
    author: author,
    label: label_title,
    publish_date: publish_date,
    publisher: publisher,
    cover_state: cover_state
  )
  book.save
  puts 'Book added successfully.'

  add_label(book, label_title)
end

def input_label_title
  print 'Label: '
  gets.chomp
end

def input_publish_date
  print 'Publish Date (YYYY-MM-DD): '
  Date.parse(gets.chomp)
end

def add_label(book, label_title)
  label_color = generate_random_color
  label = Label.new(Label.generate_id, label_title, label_color)
  label.add_item(book)
  puts "Label added successfully with color: #{label_color}."
end

def generate_random_color
  colors = %w[red blue green yellow orange purple] # Puedes agregar más colores si lo deseas
  colors.sample
end

loop do
  print_options
  option = gets.chomp.to_i

  case option
  when 1
    list_all_books
  when 2
    list_all_labels
  when 3
    add_book
  when 4
    puts 'Exiting the app. Goodbye!'
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
