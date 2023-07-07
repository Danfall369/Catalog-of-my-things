require_relative '../Method/music_album'
require_relative '../item'

describe Genre do
  let(:genre_name) { 'Sci-Fi' }
  let(:genre) { Genre.new(genre_name) }
  let(:valid_item) { Item.new('Book', 'Dune') }
  let(:invalid_item) { 'Invalid Item' }

  describe '#initialize' do
    it 'sets the genre name' do
      expect(genre.name).to eq(genre_name)
    end

    it 'generates a random id' do
      expect(genre.id).to be_an(Integer)
    end

    it 'initializes items as an empty array' do
      expect(genre.items).to eq([])
    end
  end

  describe '#add_item' do
    context 'when an invalid item is passed' do
      it 'prints "Invalid item" to the console' do
        expect { genre.add_item(invalid_item) }.to output("Invalid item\n").to_stdout
      end

      it 'does not add the item to the genre' do
        expect { genre.add_item(invalid_item) }.to_not(change { genre.items })
      end
    end
  end
end
