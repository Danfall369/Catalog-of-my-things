require_relative '../Method/music_album'
require_relative '../item'
require 'date'

describe MusicAlbum do
  let(:publish_date) { Date.new(2023, 1, 1) }
  let(:on_spotify) { true }

  subject(:music_album) { described_class.new(publish_date, on_spotify) }

  describe '#can_be_archived?' do
    context 'when the item can be archived and is on Spotify' do
      it 'returns true and sets archived to true' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(true)
        expect(music_album.can_be_archived?).to eq(true)
        expect(music_album.archived).to eq(true) # Check if archived is set to true
      end
    end

    context 'when the item cannot be archived' do
      it 'returns false' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(false)
        expect(music_album.can_be_archived?).to eq(false)
      end
    end
  end
end
