#CLI Controller
class GetDish::CLI

  def call
    # Priming
    GetDish::Scraper.new.scrape_dishes
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Looking for something Keto friendly?"
    engage
  end

  def engage
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts <<~HEREDOC
          Enter what type of Keto friendly
          dish you'd like: Meal, Snack, Drink,
          or Treat and you'll get a randomly
          selected dish! Or select exit to
          end the program.
         HEREDOC
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    input = gets.strip.downcase

    dish = dish_by_type(input).sample

    return_table(dish)

    puts "Would you like to go to the recipe for this dish: y or n?"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    answer = gets.strip.downcase

      if ["y"].include?(answer)
        go_to_recipe(dish)
      elsif ["n"].include?(answer)
        engage
      elsif ["exit"].include?(answer)
        goodbye
      else
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "I don't understand that answer."
        engage
      end
  end

  def dish_by_type(input)
    case input
     when "meal"
        GetDish::Dish.all.select { |e| e.type == "Meal"}
     when "snack"
        GetDish::Dish.all.select { |e| e.type == "Snack"}
     when "drink"
        GetDish::Dish.all.select { |e| e.type == "Drink"}
     when "treat"
        GetDish::Dish.all.select { |e| e.type == "Treat"}
     end
   end

   def return_table(dish)
       puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
       puts "#{dish.name}"
       puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
       puts "Calories per serving:     #{dish.calories}"
       puts "Fat:                      #{dish.fat}g"
       puts "Protein:                  #{dish.protein}g"
       puts "Net-Carbs:                #{dish.net_carbs}g"
       puts "Recipe:                   #{dish.url}"
       puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
   end

   def go_to_recipe(dish)
     system("xdg-open '#{dish.url}'")
   end

  # def list_all_dishes(type)
  #   GetDish::Dish.all.each_with_index do |dish, i|
  #     puts "#{i+1} #{dish.title}"
  #   end
  # end
  #
  def goodbye
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Stop by tomorrow for more dishes!"
    exit
  end

end
