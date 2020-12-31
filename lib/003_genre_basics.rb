class Genre  
  extend Concerns::Findable
  attr_accessor :name, :song, :musicimporter
  
@@all = [] 

def initialize(name) 
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

def self.create(genre) 
  genre = self.new(genre) 
  genre.save
  genre 
end 

def songs 
  @songs
end 

 def artists
    @genre_array = [] #returning a collection same as the one in Artist class 
    @songs.each do |song| #genre has many artist through songs 
      if @genre_array.include?(song.artist) #check for duplicate 
        nil
      else
        @genre_array << song.artist
      end
    end
    @genre_array
  end

end 