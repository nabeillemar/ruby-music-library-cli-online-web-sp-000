class Song 
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre, :musicimporter #these are not custom attributes, read and write 
  
@@all = [] #all new objects gets sent to this array to contain

def initialize(name, artist=nil, genre=nil) #get initialized or created using a name for argument 
  @name = name # not sure why we do this part
  self.artist=(artist) if artist != nil #don't forget the equal sign 
  self.genre=(genre) if genre != nil
end 

def genre=(genre)
  @genre = genre
  if genre.songs.include?(self)
    nil 
  else 
  genre.songs << self 
end 
end 

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end 

def self.all #class method, so we can access the array 
  @@all 
end 

def save #we make sure all new instances get saved in the array, but shouldn't this be in initialized?
  @@all << self  #copying itself and pushing it to the array global varaible 
end 


def self.destroy_all #CLass method in which all the instances get cleared out 
  @@all.clear #calling a set class method on the global varaible 
end 

def self.create(song) #class method that creates a new instance of a song, another way to initalize a custom constructor 
  song = self.new(song) #.new is the set class method and it has to accepts an argument we put in the initalize and make it equal to the song 
  song.save #calling on the save method above on the song so it can be saved to the array 
  song #returning the song 
end 

 def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
    end
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end 

def self.new_from_filename(filename)
    array = filename.split(" - ")

    song_name = array[1]
    artist_name = array[0]
    genre_name = array[2].split(".mp3").join

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
    

end 