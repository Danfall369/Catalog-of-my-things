require_relative '../lib/book'
require 'date'
require 'rspec'
require 'json'

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

  describe '#save' do
    let(:file_path) { './data/book.json' }
    let(:existing_data) { '' }
    let(:file) { double('File') }

    before do
      allow(File).to receive(:exist?).with(file_path).and_return(true)
      allow(File).to receive(:read).with(file_path).and_return(existing_data)
      allow(File).to receive(:open).with(file_path, 'w').and_yield(file)
      allow(file).to receive(:write)
    end

    context 'when the file is empty' do
      it 'writes the book data to the file' do
        book.save
        expect(file).to have_received(:write).with(JSON.generate([book_data]))
        puts "Book data saved successfully!"
      end
    end

    context 'when the file is not empty' do
      let(:existing_data) { '[{"id": 2}]' }

      it 'appends the book data to the file' do
        book.save
        expect(file).to have_received(:write).with(JSON.generate(existing_books << book_data))
        puts "Book data appended to the file successfully!"
      end
    end

    def book_data
      {
        id: 1,
        genre: 'Genre',
        author: 'Author',
        label: 'Label',
        publish_date: publish_date.to_s,
        publisher: 'Publisher',
        cover_state: 'good',
        archived: false
      }
    end

    def existing_books
      JSON.parse(existing_data)
    end
  end
end
