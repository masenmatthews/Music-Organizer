#!/usr/bin/ruby

class Artist
  attr_reader :name, :genre, :list, :albums
  @@list = []

  def initialize(attributes)
    @name = attributes[:name]
    @genre = attributes[:genre]
    @albums = []
  end

  def add_to_list
    if (self.name)
      @@list.push(self)
    end
  end

  def self.list
    @@list
  end

  def add_album(attributes)
    new_album = Album.new(attributes)
    @albums.push(new_album)
    new_album
  end

  def self.clear
    @@list.clear
  end

  def self.sort_list
    @@list.sort_by! {|artist| artist.name}
  end
end
