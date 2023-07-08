require_relative 'menu_options/book_manager'
require 'colorize'

class App
  def initialize(main)
    @main = main
    @books = []
    @albums = []
    @games = []
    @book_options = BookOptions.new(@books)
  end

  def list_books
    @book_options.list_books(@books)
    @main.display_menu
  end

  def list_genres
    puts 'List of genres:'
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No genres added yet'
    else
      puts 'Listing all genres'
      @albums.each do |genre|
        puts "Name: #{genre.genre.name}"
      end
      @books.each do |genre|
        puts "Name: #{genre.genre.name}"
      end
      @games.each do |genre|
        puts "Name: #{genre.genre.name}"
      end
    end
    @main.display_menu
  end

  def list_labels
    puts 'List of labels:'
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No labels added yet'
    else
      puts 'Listing all labels'
      @albums.each do |label|
        puts "Name: #{label.label.title} Color: #{label.label.color}"
      end
      @books.each do |label|
        puts "Name: #{label.label.title} Color: #{label.label.color}"
      end
      @games.each do |label|
        puts "Name: #{label.label.title} Color: #{label.label.color}"
      end
    end
  end

  def list_authors
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No authors added yet'
    else
      puts 'Listing all authors'
      @albums.each do |author|
        puts "Name: #{author.author.first_name} #{author.author.last_name}"
      end
      @books.each do |author|
        puts "Name: #{author.author.first_name} #{author.author.last_name}"
      end
      @games.each do |author|
        puts "Name: #{author.author.first_name} #{author.author.last_name}"
      end
    end
    @main.display_menu
  end

  def add_book
    @book_options.add_book
    @main.display_menu
  end

  def quit
    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts 'Thank you for using the Catalog App!'
    puts '-------------------------------------------------------------------------------------'
    @book_options.save_books
    exit
  end

  def load_data
    @book_options.load_books
  end
end
