require './methods/genre'
require './methods/author'
require './methods/label'
require './methods/book'
require './methods/music_album'
require 'json'

class MusicManager
  attr_accessor :albums

  def initialize(albums)
    @albums = albums
  end

  def list_music_albums(albums)
    puts '-------- List of Music Albums --------'
    if albums.empty?
      puts 'No albums found'
    else
      albums.each do |album|
        puts ''
        puts "----- Album number #{album.id} -----"
        puts "Album Name: #{album.label.title}"
        puts "Artist: #{album.author.first_name} #{album.author.last_name}"
        puts "Published on: #{album.publish_date}"
        puts "Genre: #{album.genre.name}"
        puts "Color: #{album.label.color}"
        puts "On Spotify: #{album.on_spotify}"
        puts ''
      end
    end
    puts '---------------------------------------'
  end

  def add_music_album
    puts '--- Add new album ---'
    puts 'Please, fill the required information'
    print 'Album title: '
    label_title = gets.chomp

    print 'Album genre: '
    genre_name = gets.chomp
    genre = Genre.new(genre_name)

    print 'Album author first name: '
    author_first_name = gets.chomp

    print 'Album author last name: '
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

    print 'Is on spotify? (Y/N): '
    on_spotify = gets.chomp
    on_spotify = on_spotify.upcase == 'Y'
    album = MusicAlbum.new(publish_date, on_spotify)

    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts "The Album: #{label_title}, by: #{author.first_name} #{author.last_name}, has been added"
    puts '-------------------------------------------------------------------------------------'

    genre.add_item(album)
    author.add_item(album)
    label.add_item(album)
    @albums << album
  end

  def save_music_albums
    albums_data = []
    @albums.each do |album|
      albums_data.push(
        publish_date: album.publish_date,
        genre: album.genre.name,
        label_title: album.label.title,
        label_color: album.label.color,
        author_first_name: album.author.first_name,
        author_last_name: album.author.last_name,
        on_spotify: album.on_spotify
      )
    end
    File.write('data/music_albums.json', albums_data.to_json)
  end

  def load_music_albums
    return unless File.exist?('data/music_albums.json')

    albums_data = JSON.parse(File.read('data/music_albums.json'))
    albums_data.each do |album_data|
      album_genre = Genre.new(album_data['genre'])
      album_label = Label.new(Random.rand(1..1000), album_data['label_title'], album_data['label_color'])
      album_author = Author.new(album_data['author_first_name'], album_data['author_last_name'])
      album = MusicAlbum.new(album_data['publish_date'], album_data['on_spotify'])
      album_genre.add_item(album)
      album_label.add_item(album)
      album_author.add_item(album)
      @albums << album
    end
  end
end
