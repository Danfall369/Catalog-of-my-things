require_relative 'app'
require_relative 'game'

def game_options(data)
  puts 'Select author from the following list by index: '
  data.authors.each_with_index do |item, index|
    puts "[#{index}]: Name: #{item.first_name} #{item.last_name}"
  end
  author = gets.chomp.to_i
  puts 'Select the genre from the following list by index: '
  data.genres.each_with_index do |item, index|
    puts "[#{index}]: Name: #{item.name}"
  end
  genre = gets.chomp.to_i
  puts 'Select source from the following list by index: '
  data.sources.each_with_index do |item, index|
    puts "[#{index}]: Name: #{item.name}"
  end
  source = gets.chomp.to_i
  puts 'Select the label from the following list by index: '
  data.labels.each_with_index do |item, index|
    puts "[#{index}]: Title: #{item.title} Color: #{item.color}"
  end
  label = gets.chomp.to_i
  puts 'Publish date? Please enter in this format: YYYY/MM/DD'
  publish_date = gets.chomp
  puts 'Is this game multiplayer?'
  multiplayer = gets.chomp
  puts 'What is the last played date? Please enter in this format: YYYY/MM/DD'
  last_played_at = gets.chomp

  create_game(publish_date, multiplayer, last_played_at, author, label, source, genre, data)
end

def create_game(publish_date, multiplayer, last_played_at, author, label, source, genre, data)
  game = Game.new(publish_date, multiplayer, last_played_at, genre, author, source, label)
  game.author = data.authors[author.to_i]
  game.label = data.labels[label.to_i]
  game.source = data.sources[source.to_i]
  game.genre = data.genres[genre.to_i]
  @games.push(game)
end
