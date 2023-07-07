class Genre
  attr_accessor :id, :name, :items

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    if item.is_a?(Item)
      @items << item
      item.genre = self
    else
      puts 'Invalid item'
    end
  end
end
