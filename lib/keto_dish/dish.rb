class KetoDish::Dish

  #Class Instance Variables
  attr_accessor :name, :calories, :url, :protein, :fat, :net_carbs, :dish_type

  #Class Container
  @@all = []

  def initialize(attr_hash)
    # we're going to build dishes here
    # let's do it using mass assignment
    attr_hash.each { |attr_name, attr_value| self.send("#{attr_name}=", attr_value) }
    # notice this #save call is what was missing near the end of our live coding session:
    # (you were calling from the Scraper class but we can just call it here)
    self.save
  end


  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find {|dish| dish.name == name}
  end

  #saves dish instances created by Scraper class
  def save
    # you could also add logic here to prevent duplicates from being persisted to @@all
    @@all << self
  end

end

# Andrew, here is what I was talking about during our session.
# This is a printout of my terminal after several iterations
# of choosing various meals from the menu.  Notice that the same
# recipe for Sesame Chicken is now in memory 6 times.  How can we
# ensure this doesn't happen?

=begin

[2] pry(#<KetoDish::Scraper>)> KetoDish::Dish.all.select {|dish| dish.name == "Sesame Chicken"}
=> [#<KetoDish::Dish:0x00007fb953ce2688
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
  @net_carbs=4,
  @protein=45,
  @url="https://ketodash.com/recipe/sesame-chicken">,
 #<KetoDish::Dish:0x00007fb953cd6a40
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
  @net_carbs=4,
  @protein=45,
  @url="https://ketodash.com/recipe/sesame-chicken">,
 #<KetoDish::Dish:0x00007fb957d43e20
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
  @net_carbs=4,
  @protein=45,
  @url="https://ketodash.com/recipe/sesame-chicken">,
 #<KetoDish::Dish:0x00007fb954052fc0
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
  @net_carbs=4,
  @protein=45,
  @url="https://ketodash.com/recipe/sesame-chicken">,
 #<KetoDish::Dish:0x00007fb9569a8d20
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
[3] pry(#<KetoDish::Scraper>)> KetoDish::Dish.all.select {|dish| dish.name == "Sesame Chicken"}.count
=> 6

Once you've coded a solution, the output should look like this:
[4] pry(#<KetoDish::Scraper>)> KetoDish::Dish.all.select {|dish| dish.name == "Sesame Chicken"}
=> [#<KetoDish::Dish:0x00007fc90acb5d38
  @calories=520,
  @dish_type="Meal",
  @fat=36,
  @name="Sesame Chicken",
  @net_carbs=4,
  @protein=45,
  @url="https://ketodash.com/recipe/sesame-chicken">]
[5] pry(#<KetoDish::Scraper>)> KetoDish::Dish.all.select {|dish| dish.name == "Sesame Chicken"}.count
=> 1
=end
