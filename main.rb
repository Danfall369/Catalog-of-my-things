# main.rb
require_relative 'item'

def print_options
  puts 'Options:'
  puts '1. Add an item'
  puts '2. Move item to archived'
  puts '3. Quit'
end

def add_item
  # Implement the logic to add an item
end

def move_to_archived
  # Implement the logic to move an item to archived
end

loop do
  print_options
  option = gets.chomp.to_i

  case option
  when 1
    add_item
  when 2
    move_to_archived
  when 3
    puts 'Exiting the app. Goodbye!'
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
