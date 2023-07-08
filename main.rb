require_relative 'app'

class Main
  def initialize
    @app = App.new(self)
    puts ''
    puts '-------------------------------------------------------------------------------------'
    puts 'Welcome to the Catalog App'
    puts '-------------------------------------------------------------------------------------'
    @app.load_data
    display_menu
  end

  def display_menu
    loop do
      puts ''
      puts 'Please choose an option by entering a number:'
      puts ''
      puts '1. List all books'
      puts '2. List all genres'
      puts '3. List all labels'
      puts '4. List all authors'
      puts '5. Add a book'
      puts '6. Exit'
      puts
      user_choice = gets.chomp
      option_selected(user_choice)
    end
  end

  def option_selected(user_choice)
    options = {
      '1' => :list_books,
      '2' => :list_genres,
      '3' => :list_labels,
      '4' => :list_authors,
      '5' => :add_book,
      '6' => :quit
    }

    method = options[user_choice]
    if method.nil?
      puts 'Invalid option'
      display_menu
    else
      @app.send(method)
    end
  end
end

Main.new
