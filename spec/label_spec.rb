require_relative '../lib/label'
require_relative '../lib/item'
require 'rspec'
require 'date'

describe Label do
  let(:label) { Label.new(1, 'Label Title', 'Label Color') }
  let(:item) { Item.new(1, 'Genre', 'Author', label, Date.new(2023, 1, 1)) }

  describe '#add_item' do
    it 'adds the item to the items collection' do
      label.add_item(item)
      expect(label.items).to include(item)
      puts 'Item added to the items collection.'
    end

    it 'sets the label property of the item' do
      label.add_item(item)
      expect(item.label).to eq(label)
      puts 'Label property of the item set successfully.'
    end
  end
end
