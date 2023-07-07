class Author
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(first_name, last_name)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.author = self
  end

  private

  def id
    Random.rand(1..1000)
  end
end
