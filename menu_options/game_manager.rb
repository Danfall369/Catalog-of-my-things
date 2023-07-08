require './methods/genre'
require './methods/author'
require './methods/label'
require './methods/game'
require 'json'

class GameOptions
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def list_games(games)
    puts '------------ List of Games ------------'
    if games.empty?
      puts 'No games found'
    else
      games.each do |game|
        puts ''
        puts "----- Game number #{game.id} -----"
        puts "Game Title: #{game.label.title}"
        puts "Director: #{game.author.first_name} #{game.author.last_name}"
        puts "Published on: #{game.publish_date}"
        puts "Last time played: #{game.last_played_at}"
        puts "Genre: #{game.genre.name}"
        puts "Multiplayer available: #{game.multiplayer ? 'Yes' : 'No'}"
        puts ''
      end
    end
    puts '---------------------------------------'
  end

  def add_game
    puts '--- Add new game ---'
    puts 'Please, fill the required information'
    print 'Game title: '
    label_title = gets.chomp

    print 'Game genre: '
    genre_name = gets.chomp
    genre = Genre.new(genre_name)

    print 'Game direcor first name: '
    author_first_name = gets.chomp

    print 'Game direcor last name: '
    author_last_name = gets.chomp

    author = Author.new(author_first_name, author_last_name)

    print 'Enter the label color: '
    label_color = gets.chomp
    label = Label.new(Random.rand(1..1000), label_title, label_color)

    print 'Does it have multiplayer? (Y/N): '
    multiplayer_game = gets.chomp.downcase == 'y'
    print 'Published on (YYYY-MM-DD): '
    released_date = gets.chomp
    print 'Last time played (YYYY-MM-DD): '
    last_played_date = gets.chomp
    game = Game.new(multiplayer_game, last_played_date, released_date)

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts "the Game: #{label.title}, by: #{author.first_name} #{author.last_name}, has been added"
    puts '-------------------------------------------------------------------------------------'

    genre.add_item(game)
    author.add_item(game)
    label.add_item(game)
    @games << game
  end

  def save_games
    games_data = []
    @games.each do |game|
      games_data.push(
        publish_date: game.publish_date,
        genre: game.genre.name,
        label_title: game.label.title,
        label_color: game.label.color,
        author_first_name: game.author.first_name,
        author_last_name: game.author.last_name,
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at
      )
    end
    File.write('data/game.json', games_data.to_json)
  end

  def load_games
    return unless File.exist?('Storage/game.json')

    games_data = JSON.parse(File.read('Storage/game.json'))
    games_data.each do |game_data|
      game_genre = Genre.new(game_data['genre'])
      game_label = Label.new(Random.rand(1..1000), game_data['label_title'], game_data['label_color'])
      game_author = Author.new(game_data['author_first_name'], game_data['author_last_name'])
      game = Game.new(game_data['multiplayer'], game_data['last_played_at'], game_data['publish_date'])
      game_genre.add_item(game)
      game_label.add_item(game)
      game_author.add_item(game)
      @games << game
    end
  end
end