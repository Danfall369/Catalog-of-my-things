require_relative '../item'
require 'date'

describe Item do
  let(:publish_date) { Date.new(2000, 1, 1) }
  let(:item) { Item.new(publish_date) }

  describe '#initialize' do
    it 'generates a random id' do
      expect(item.id).to be_an(Integer)
    end

    it 'sets the publish date' do
      expect(item.publish_date).to eq(publish_date)
    end

    it 'sets archived to false' do
      expect(item.archived).to be_falsey
    end
  end
end
