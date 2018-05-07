require "pry"
class KetoDish::Dish

  #Class Instance Variables
  attr_accessor :name, :calories, :url, :protein, :fat, :net_carbs, :dish_type

  def initialize(attr_hash)
    # we're going to build dishes here
    # let's do it using mass assignment
    attr_hash.each { |attr_name, attr_value| self.send("#{attr_name}=", attr_value) }
    @@all << self
  end

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
Pry.start
