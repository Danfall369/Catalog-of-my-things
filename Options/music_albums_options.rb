require_relative '../Method/genre'
require_relative '../Method/music_album'
require_relative '../Method/label'
require 'json'

class MusicAlbumOptions
  attr_accessor :music_albums, :genres, :labels

  def initialize(item_attributes_data, storage)
    @music_albums = []
    @genres = item_attributes_data.genres
    @storage = storage
    @labels = storage.load_labels || []
  end