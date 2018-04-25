#CLI Controller

class GetDish::CLI

  def call
    list_dish
    menu
    goodbye
  end

  def list_dish
    @dish = GetDish::Dish.today
    @dish.each_with_index(1) do |dish, i|
      puts "#{i}. #{dish.name} - #{dish.calories} - #{dish.protein} - #{dish.fat}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter dish number for more info, list, or exit:"
     input = gets.strip.downcase

     if input.to_i > 0
       the_knife = @dish[input.to_i -1]
     elsif input == "list"
       list_deals
     else
       "Please type in: list or exit"
     end
    end
  end

  def goodbye
    p "Stop by tomorrow for new dishes!"
  end

end
