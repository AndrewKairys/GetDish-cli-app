class KetoDish::Scraper

  def initialize(url = nil)
    @url = url
  end

  def scrape_dishes
    #scrape a dish based on user input of types: Meal, Snack, Treat, Drink.
    html = "https://ketodash.com/recipe"
    @doc = Nokogiri::HTML(open(html))
    #parse first Nokogiri @doc into more manageable nodes
    card_doc = @doc.css("div.col-sm-6.col-lg-4")
    card_doc.each do |child|
      dish = KetoDish::Dish.new
      dish.type = child.css("span.badge").text
      dish.name = child.css("h5 a").text.strip
      dish.calories = child.css("li.list-group-item")[0].text.split.pop.to_i
      dish.protein = child.css("li.list-group-item")[1].text.split.pop.to_i
      dish.fat = child.css("li.list-group-item")[2].text.split.pop.to_i
      dish.net_carbs = child.css("li.list-group-item")[3].text.split.pop.to_i
      dish.url = html + child.css("h5 a").attr("href").text.gsub("/recipe", "")

      #binding.pry
      dish.save
    end
  end

end
