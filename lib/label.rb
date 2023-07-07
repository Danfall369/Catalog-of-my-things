require 'json'

class Label
  attr_reader :id, :title, :color
  attr_accessor :items

  def initialize(id, title, color)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
    save
  end

  def save
    labels = []

    if File.exist?(self.class.file_path)
      existing_data = File.read(self.class.file_path)
      labels = JSON.parse(existing_data) unless existing_data.empty?
    end

    label_data = {
      id: id,
      title: title,
      color: color,
      item_ids: items.map(&:id)
    }

    labels << label_data

    File.open(self.class.file_path, 'w') do |file|
      file.write(JSON.generate(labels))
    end
  end

  def self.load_from_file
    labels = []

    if File.exist?(file_path)
      data = File.read(file_path)
      labels_data = JSON.parse(data) unless data.empty?

      labels_data.each do |label_data|
        id = label_data['id']
        title = label_data['title']
        color = label_data['color']
        item_ids = label_data['item_ids']

        items = Item.load_from_file.select { |item| item_ids.include?(item.id) }

        label = Label.new(id, title, color)
        label.items = items
        labels << label
      end
    end

    labels
  end

  def self.file_path
    './data/labels.json'
  end
end
