#CLI Controller
class KetoDish::CLI

  def call
    # Priming
    KetoDish::Scraper.new.scrape_dishes
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts <<~HEREDOC
          Looking for something Keto friendly?
          Please type random or R, if you'd
          like to select a dish randomly by
          type. Or select list or L, and a
          list of dishes by type will appear!
          Or type exit to close.
        HEREDOC
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    choice = gets.strip.downcase

      if ["r", "random"].include?(choice)
        random
      elsif ["l", "list"].include?(choice)
        dish_list
      elsif ["exit"].include?(choice)
        goodbye
      else
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "I don't understand that answer."
        call
      end
  end

#List Fork
  def dish_list
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts <<~HEREDOC
          Enter which type of Keto friendly
          dish you'd like: Meal, Snack, Drink,
          or Treat and you'll get a list of
          randomly selected dishes based on
          the type you selected! Or type exit
          to end the program.
         HEREDOC
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    input = gets.strip.downcase

      # Probably need to send input to a validation method
      # if input == "meal" || "snack" || "treat" || "drink"
      #   dishes = dish_by_type(input).sample(10)
      # else
      #   start_list
      # end
    dishes = dish_by_type(input).sample(10)

    list_dishes(dishes)

    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Please enter which number you'd like more information on."
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    input = gets.strip.to_i

    return_table(dishes[input-1])

    puts "Would you like to go to the recipe for this dish: y or n?"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    answer = gets.strip.downcase

      if ["y"].include?(answer)
        go_to_recipe(dishes[input])
      elsif ["n"].include?(answer)
        call
      elsif ["exit"].include?(answer)
        goodbye
      else
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "I don't understand that answer."
        call
      end
  end

#Random Fork
  def random
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts <<~HEREDOC
          Enter what type of Keto friendly
          dish you'd like: Meal, Snack, Drink,
          or Treat and you'll get a randomly
          selected dish! Or type exit to
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
        call
      elsif ["exit"].include?(answer)
        goodbye
      else
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "I don't understand that answer."
        call
      end
  end

  def return_table(input)
    dish = input
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "#{dish.name}"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Calories per serving:    #{dish.calories} kcal"
      puts "Fat:                     #{dish.fat} g"
      puts "Protein:                 #{dish.protein} g"
      puts "Net-Carbs:               #{dish.net_carbs} g"
      puts "Recipe:                  #{dish.url}"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def dish_by_type(input)
    case input
     when "meal"
        KetoDish::Dish.all.select { |e| e.type == "Meal"}
     when "snack"
        KetoDish::Dish.all.select { |e| e.type == "Snack"}
     when "drink"
        KetoDish::Dish.all.select { |e| e.type == "Drink"}
     when "treat"
        KetoDish::Dish.all.select { |e| e.type == "Treat"}
     end
   end



   def go_to_recipe(dish)
     system("xdg-open '#{dish.url}'")
     call
   end

   def list_dishes(dish)
     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     dish.each_with_index do |dish, i|
       puts "#{i+1}." "#{dish.name}"
     end
   end

  def goodbye
    puts "Stop by tomorrow for more dishes!"
    exit
  end

end
