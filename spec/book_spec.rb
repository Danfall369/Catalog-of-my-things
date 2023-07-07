require_relative '../lib/book'
require 'date'
require 'rspec'

describe Book do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:book) do
    Book.new(
      id: 1,
      genre: 'Genre',
      author: 'Author',
      label: 'Label',
      publish_date: publish_date,
      publisher: 'Publisher',
      cover_state: 'good'
    )
  end

  describe '#initialize' do
    it 'initializes a book object with provided attributes' do
      expect(book.id).to eq(1)
      expect(book.genre).to eq('Genre')
      expect(book.author).to eq('Author')
      expect(book.label).to eq('Label')
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq('Publisher')
      expect(book.cover_state).to eq('good')
      expect(book.archived).to eq(false)
    end
  end

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
      let(:book) do
        Book.new(
          id: 1,
          genre: 'Genre',
          author: 'Author',
          label: 'Label',
          publish_date: publish_date,
          publisher: 'Publisher',
          cover_state: 'bad'
        )
      end

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
    let(:existing_books) { [] }

    before do
      allow(File).to receive(:exist?).with(file_path).and_return(true)
      allow(File).to receive(:read).with(file_path).and_return(existing_data)
      allow(File).to receive(:write)
    end

    it 'writes the book data to the file when the file is empty' do
      book.save
      expect(File).to have_received(:write).with(file_path, JSON.generate([book_data]))
    end

    context 'when the file is not empty' do
      let(:existing_data) { '[{"id": 2}]' }
      let(:existing_books) { JSON.parse(existing_data) }

      it 'appends the book data to the file' do
        book.save
        expect(File).to have_received(:write).with(file_path, JSON.generate(existing_books << book_data))
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
  end

  describe '.load_from_file' do
    let(:file_path) { './data/book.json' }
    let(:book_data) do
      [
        {
          'id' => 1,
          'genre' => 'Genre',
          'author' => 'Author',
          'label' => 'Label',
          'publish_date' => publish_date.to_s,
          'publisher' => 'Publisher',
          'cover_state' => 'good',
          'archived' => false
        },
        {
          'id' => 2,
          'genre' => 'Genre2',
          'author' => 'Author2',
          'label' => 'Label2',
          'publish_date' => (Date.today - 1).to_s,
          'publisher' => 'Publisher2',
          'cover_state' => 'good',
          'archived' => true
        }
      ]
    end

    before do
      allow(File).to receive(:exist?).with(file_path).and_return(true)
      allow(File).to receive(:read).with(file_path).and_return(JSON.generate(book_data))
    end

    it 'returns an array of Book objects loaded from the file' do
      books = Book.load_from_file

      expect(books.size).to eq(2)

      expect(books[0].id).to eq(1)
      expect(books[0].genre).to eq('Genre')
      expect(books[0].author).to eq('Author')
      expect(books[0].label).to eq('Label')
      expect(books[0].publish_date).to eq(publish_date)
      expect(books[0].publisher).to eq('Publisher')
      expect(books[0].cover_state).to eq('good')
      expect(books[0].archived).to eq(false)

      expect(books[1].id).to eq(2)
      expect(books[1].genre).to eq('Genre2')
      expect(books[1].author).to eq('Author2')
      expect(books[1].label).to eq('Label2')
      expect(books[1].publish_date).to eq(Date.today - 1)
      expect(books[1].publisher).to eq('Publisher2')
      expect(books[1].cover_state).to eq('good')
      expect(books[1].archived).to eq(true)
    end
  end

  describe '.file_path' do
    it 'returns the file path of the book data file' do
      expect(Book.file_path).to eq('./data/book.json')
    end
  end
end
