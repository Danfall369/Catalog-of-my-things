require_relative '../Method/author'
require_relative '../item'

describe Author do
  describe '#initialize' do
    it 'author must be created' do
      author = Author.new('Elijah', 'Vitoesi')
      expect(author.first_name).to eq('Elijah')
      expect(author.last_name).to eq('Vitoesi')
      expect(author.items).to be_empty
    end
  end
end
