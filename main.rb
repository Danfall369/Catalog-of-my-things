require_relative 'app'

class Main
  def initialize
    @app = App.new(self)
    puts ''
    puts '------------------------------------------------------------------------'
    puts 'Welcome to the Catalog App'
    puts '------------------------------------------------------------------------'
    @app.load_data
    display_menu
  end

  def display_menu
    loop do
      puts ''
      puts 'Please choose an option by entering a number:'
      puts ''
      puts '1. List all books'
      puts '2. List all music albums'
      puts '3. List all genres'
      puts '4. List all labels'
      puts '5. List all authors'
      puts '6. Add a book'
      puts '7. Add a music album'
      puts '8. Exit'
      puts
      user_choice = gets.chomp
      option_selected(user_choice)
    end
  end

  def option_selected(user_choice)
    options = {
      '1' => :list_books,
      '2' => :list_music_albums,
      '3' => :list_genres,
      '4' => :list_labels,
      '5' => :list_authors,
      '6' => :add_book,
      '7' => :add_music_album,
      '8' => :quit
    }

    method = options[user_choice]
    if method.nil?
      puts 'Invalid option, please try again.'
      display_menu
    else
      @app.send(method)
    end
  end
end

Main.new
