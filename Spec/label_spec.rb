require_relative '../item'
require_relative '../Method/label'

RSpec.describe Label do
  describe '#add_item' do
    it 'adds the item to the labels items array' do
      label = Label.new(1, 'Test Label', 'red')
      item = Item.new('Item 1')

      label.add_item(item)

      expect(label.items).to include(item)
    end

    it 'sets the label as the items label' do
      label = Label.new(1, 'Test Label', 'red')
      item = Item.new('Item 1')

      label.add_item(item)

      expect(item.label).to eq(label)
    end
  end
end

RSpec.describe Label do
  describe '#initialize' do
    it 'initializes the label object with the given attributes' do
      label = Label.new(1, 'Test Label', 'red')

      expect(label.id).to eq(1)
      expect(label.title).to eq('Test Label')
      expect(label.color).to eq('red')
      expect(label.items).to be_empty
    end
  end
end
