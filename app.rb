require_relative 'menu_options/book_manager'
require_relative 'menu_options/music_manager'
require_relative 'menu_options/game_manager'
require 'colorize'

class App
  def initialize(main)
    @main = main
    @books = []
    @albums = []
    @games = []
    @music_albums = MusicManager.new(@albums)
    @book_options = BookOptions.new(@books)
    @music_albums = MusicManager.new(@albums)
    @game_options = GameOptions.new(@games)
  end

  def list_books
    @book_options.list_books(@books)
    @main.display_menu
  end

  def list_music_albums
    @music_albums.list_music_albums(@albums)
    @main.display_menu
  end

  def list_games
    @game_options.list_games(@games)
    @main.display_menu
  end

  def list_genres
    puts '-------- List of genres: --------'
    puts ''
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No genres added yet'
    else
      @albums.each do |genre|
        puts "Genre Name: #{genre.genre.name}"
      end
      @books.each do |genre|
        puts "Genre Name: #{genre.genre.name}"
      end
      @games.each do |genre|
        puts "Genre Name: #{genre.genre.name}"
      end
    end
    puts ''
    puts '---------------------------------'
    @main.display_menu
  end

  def list_labels
    puts '-------- List of Labels: --------'
    puts ''
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No labels added yet'
    else
      @albums.each do |label|
        puts "Label Name: #{label.label.title} | Label Color: #{label.label.color}"
      end
      @books.each do |label|
        puts "Label Name: #{label.label.title} | Label Color: #{label.label.color}"
      end
      @games.each do |label|
        puts "Label Name: #{label.label.title} | Label Color: #{label.label.color}"
      end
    end
    puts ''
    puts '---------------------------------'
  end

  def list_authors
    puts '-------- List of Authors: --------'
    puts ''
    if @albums.empty? and @books.empty? and @games.empty?
      puts 'No authors added yet'
    else
      @albums.each do |author|
        puts "Full-Name: #{author.author.first_name} #{author.author.last_name}"
      end
      @books.each do |author|
        puts "Full-Name: #{author.author.first_name} #{author.author.last_name}"
      end
      @games.each do |author|
        puts "Full-Name: #{author.author.first_name} #{author.author.last_name}"
      end
    end
    puts ''
    puts '---------------------------------'
    @main.display_menu
  end

  def add_book
    @book_options.add_book
    @main.display_menu
  end

  def add_music_album
    @music_albums.add_music_album
    @main.display_menu
  end

  def add_game
    @game_options.add_game
    @main.display_menu
  end

  def quit
    puts ''
    puts '--------------------------------------------------------------'
    puts 'Thank you for using the Catalog App!'
    puts '--------------------------------------------------------------'
    @book_options.save_books
    @music_albums.save_music_albums
    @game_options.save_games
    exit
  end

  def load_data
    @music_albums.load_music_albums
    @book_options.load_books
    @game_options.load_games
  end
end