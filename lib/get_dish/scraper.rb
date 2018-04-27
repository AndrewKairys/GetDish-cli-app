class GetDish::Scraper

  def initialize(url = nil)
    @url = url
  end

  def self.scrape_dishes
    #scrape a dish based on user input of types: Meal, Snack, Treat, Drink.
    html = "https://ketodash.com/recipe"
    @doc = Nokogiri::HTML(open(html))
    random_recipe = doc.css("div.card").text.split
    random_recipe.each do |child|
      binding.pry
      name = doc.css("h5 a")[0].text.strip
      calories = doc.css("li.list-group-item")[0].text.split.pop.to_i
      protein = doc.css("li.list-group-item")[1].text.split.pop.to_i
      fat = doc.css("li.list-group-item")[2].text.split.pop.to_i
      net_carbs = doc.css("li.list-group-item")[3].text.split.pop.to_i
      url = html + doc.css("h5 a").attr("href").text
    end
  end



end
