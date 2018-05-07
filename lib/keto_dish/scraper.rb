class KetoDish::Scraper

  # consider removing #initialize and making all methods class methods
  def initialize(url = nil)
    @url = url
  end

  def scrape_dishes
    #scrape a dish based on user input of types: Meal, Snack, Treat, Drink.
    html = "https://ketodash.com/recipe"
    doc = Nokogiri::HTML(open(html))
    #parse first Nokogiri doc into more manageable nodes
    card_doc = doc.css("div.col-sm-6.col-lg-4")
    card_doc.each do |child|
      dish_attrs = {}
      dish_attrs[:dish_type] = child.css("span.badge").text
      dish_attrs[:name] = child.css("h5 a").text.strip
      dish_attrs[:calories] = child.css("li.list-group-item")[0].text.split.pop.to_i
      dish_attrs[:protein] = child.css("li.list-group-item")[1].text.split.pop.to_i
      dish_attrs[:fat] = child.css("li.list-group-item")[2].text.split.pop.to_i
      dish_attrs[:net_carbs] = child.css("li.list-group-item")[3].text.split.pop.to_i
      dish_attrs[:url] = html + child.css("h5 a").attr("href").text.gsub("/recipe", "")
      # hint: you could just add to the following line to prevent duplicates, using our
      # self.find_by_name method built in Dish ... the advantage to putting the
      # logic here is we don't create new Dish objects at all if there's already
      # one that exists... we are assuming in this case that names are unique (which
      # is probably fine in this case but won't always do it for us in other apps)
      KetoDish::Dish.new(dish_attrs)
      # binding.pry
      # we don't need to call #save here anymore, as we're taking care of it in the Dish class
      # dish.save
    end
    # binding.pry
  end

end
