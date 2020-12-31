class Artist  
  extend Concerns::Findable
  attr_accessor :name, :song, :genre, :musicimporter
  
@@all = [] 

def initialize(name) #why can't we use :name, when do we use that again need to look back 
  @name = name 
  @songs = []
end 

def self.all 
  @@all 
end 

def save
  @@all << self  
end 


def self.destroy_all 
  @@all.clear 
end 

def self.create(artist) 
  artist = self.new(artist) 
  artist.save
  artist 
end 

def songs 
  @songs
end 

  def add_song(song)
  if song.artist == nil 
    song.artist = self
  else 
    nil
  end 
  if @songs.include?(song)
    nil 
  else 
  @songs << song 
  end
  song 
end 

 def genres
    @genre_array = []
    @songs.each do |song|
      if @genre_array.include?(song.genre)
        nil
      else
        @genre_array << song.genre
      end
    end
    @genre_array
  end

end 
