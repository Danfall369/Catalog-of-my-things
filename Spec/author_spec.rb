require_relative '../Method/author'
require_relative '../item'

describe Author do
  describe '#initialize' do
    it 'author must be created' do
      author = Author.nclass Author
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
ew('Elijah', 'Vitoesi')
      expect(author.first_name).to eq('Elijah')
      expect(author.last_name).to eq('Vitoesi')
      expect(author.items).to be_empty
    end
  end
end
