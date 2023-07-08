require './item'
require './methods/game'
require 'date'

describe Game do
  let(:game) { Game.new(true, last_played_at, '2005-12-28') }
  let(:last_played_at) { '2011-06-30' }

  describe '#can_be_archived?' do
    context 'when the item cannot be archived' do
      let(:item) { double('item') }

      before do
        allow(game).to receive(:super)
      end

      it 'returns false' do
        expect(game.can_be_archived?).to be(true)
      end
    end

    context 'when the item can be archived' do
      let(:item) { double('item') }

      before do
        allow(game).to receive(:super)
      end

      it 'returns true' do
        expect(game.can_be_archived?).to be(true)
      end
    end
  end
end
