require './item'
require './methods/author'

describe Author do
  describe '#initialize' do
    it 'author must be created' do
      author = Author.new('John', 'Doe')
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
      expect(author.items).to be_empty
    end
  end
end
