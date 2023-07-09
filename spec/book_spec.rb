require './item'
require './methods/book'
require 'date'

describe Book do
  let(:publish_date) { Date.new(2015, 0o4, 16) }
  let(:publisher) { 'Example Publisher' }
  let(:cover_state) { 'Bad' }

  subject(:book) { described_class.new(publish_date, publisher, cover_state) }

  describe '#initialize' do
    it 'sets the publish_date, publisher, and cover_state' do
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq('Bad')
    end
  end

  describe '#can_be_archived?' do
    context 'when publish_date is nil' do
      let(:publish_date) { nil }

      it 'returns false' do
        expect(book.can_be_archived?).to be false
      end
    end

    context 'when publish_date is more than 10 years ago' do
      let(:publish_date) { Date.new(2010, 1, 1) }

      it 'returns true' do
        expect(book.can_be_archived?).to be true
      end
    end

    context 'when cover_state is bad' do
      let(:cover_state) { 'bad' }

      it 'returns true' do
        expect(book.can_be_archived?).to be true
      end
    end
  end
end
