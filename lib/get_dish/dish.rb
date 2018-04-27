class GetDish::Dish

  #Class Instance Variables
  attr_accessor :name, :calories, :url, :protein, :fat, :net_carbs

  #Class Container
  @@all = []

  #saves dish instances created by Scraper class
  def save
    @@all << self
  end

end
