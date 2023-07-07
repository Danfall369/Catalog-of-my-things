require_relative '../item'
require_relative '../Method/book'
require 'date'

RSpec.describe Book do
  describe '#initialize' do
    it 'initializes the book object with the given attributes' do
      publish_date = Date.new(2000, 1, 1)
      title = 'Test Book'
      publisher = 'Test Publisher'
      color = 'blue'
      cover_state = 'good'

      book = Book.new(publish_date, title, publisher, color, cover_state)

      expect(book.publish_date).to eq(publish_date)
      expect(book.title).to eq(title)
      expect(book.publisher).to eq(publisher)
      expect(book.color).to eq(color)
      expect(book.cover_state).to eq(cover_state)
      expect(book.labels).to be_empty
    end
  end
end

RSpec.describe Book do
  describe '#can_be_archived?' do
    context 'when the publish date is more than 10 years ago' do
      it 'returns true' do
        publish_date = Date.new(2010, 1, 1)
        book = Book.new(publish_date, 'Test Book', 'Test Publisher', 'blue', 'good')

        expect(book.can_be_archived?).to be true
      end
    end

    context 'when the publish date is less than 10 years ago' do
      it 'returns false' do
        publish_date = Date.today
        book = Book.new(publish_date, 'Test Book', 'Test Publisher', 'blue', 'good')

        expect(book.can_be_archived?).to be false
      end
    end
  end
end
