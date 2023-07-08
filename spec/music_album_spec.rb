require './methods/music_album'
require './item'
require 'date'

describe MusicAlbum do
  let(:publish_date) { Date.new(2001, 3, 16) }
  let(:on_spotify) { true }

  subject(:music_album) { described_class.new(publish_date, on_spotify) }

  describe '#can_be_archived?' do
    context 'when item can be archived and "on_spotify" is True' do
      it 'returns true' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(true)
        expect(music_album.can_be_archived?).to eq(true)
        expect(music_album.on_spotify).to eq(true)
      end
    end

    context 'when item can be archived and "on_spotify" is False' do
      it 'returns false' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(true)
        music_album.on_spotify = false
        expect(music_album.can_be_archived?).to eq(false)
        expect(music_album.on_spotify).to eq(false)
      end
    end
  end
end
