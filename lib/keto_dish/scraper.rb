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

      KetoDish::Dish.new(dish_attrs)
      # binding.pry
      # dish.save
    end
  end

end
