class KetoDish::Dish

  #Class Instance Variables
  attr_accessor :name, :calories, :url, :protein, :fat, :net_carbs, :type

  #Class Container
  @@all = []

  def self.all
    @@all
  end

  #saves dish instances created by Scraper class
  def save
    @@all << self
  end



end
