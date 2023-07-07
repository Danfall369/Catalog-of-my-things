require_relative '../lib/book'
require 'date'
require 'rspec'

describe Book do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:book) { Book.new(1, 'Genre', 'Author', 'Label', publish_date, 'Publisher', 'good') }

  describe '#can_be_archived?' do
    context 'when the publish date is more than 10 years ago' do
      it 'returns true' do
        expect(book.can_be_archived?).to eq(true)
      end
    end

    context 'when the publish date is within the last 10 years' do
      let(:publish_date) { Date.today }

      it 'returns false' do
        expect(book.can_be_archived?).to eq(false)
      end
    end

    context 'when the cover state is bad' do
      let(:book) { Book.new(1, 'Genre', 'Author', 'Label', publish_date, 'Publisher', 'bad') }

      it 'returns true' do
        expect(book.can_be_archived?).to eq(true)
      end
    end
  end

  describe '#move_to_archived' do
    context 'when the book can be archived' do
      before { allow(book).to receive(:can_be_archived?).and_return(true) }

      it 'sets archived to true' do
        book.move_to_archived
        expect(book.archived).to eq(true)
      end

      it 'prints "Item moved to archived."' do
        expect { book.move_to_archived }.to output("Item moved to archived.\n").to_stdout
      end
    end

    context 'when the book cannot be archived' do
      before { allow(book).to receive(:can_be_archived?).and_return(false) }

      it 'does not set archived to true' do
        book.move_to_archived
        expect(book.archived).to eq(false)
      end

      it 'prints "Item cannot be archived."' do
        expect { book.move_to_archived }.to output("Item cannot be archived.\n").to_stdout
      end
    end
  end
end
