class GetDish::Dish

  attr_accessor :name, :calories, :url, :protein, :fat, :net_carbs


  def self.today
    #scrape Keto Dash:
    #https://ketodash.com/recipe

    self.scrape_site
  end

  def self.scrape_site
    @dish = []
    html = "https://ketodash.com/recipe"
    doc = Nokogiri::HTML(open(html))
      name = doc.css("h5 a")[0].text.strip
      calories = doc.css("li.list-group-item")[0].text.split.pop.to_i
      protein = doc.css("li.list-group-item")[1].text.split.pop.to_i
      fat = doc.css("li.list-group-item")[2].text.split.pop.to_i
      net_carbs = doc.css("li.list-group-item")[3].text.split.pop.to_i
      url = html + doc.css("h5 a").attr("href").text

      @dish.push(
      name: name,
      calories: calories,
      protein: protein,
      fat: fat,
      net_carbs: net_carbs,
      url: url)

    @dish
    #binding.pry
  end

end
