require_relative '../item'
require_relative '../Method/book'
require 'date'

describe Game do
  let(:last_played_at) { '2021-07-20' }
  let(:game) { Game.new(true, last_played_at, '2021-07-20') }

  describe '#can_be_archived?' do
    context 'when the item cannot be archived' do
      let(:item) { double('item') }

      before do
        allow(game).to receive(:super).and_return(false)
      end