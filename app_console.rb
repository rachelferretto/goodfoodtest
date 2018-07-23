# pry session with your data models loaded. Separates this from the main to prtect records from sql injections


require 'pry'
require_relative 'db_config'
require_relative 'models/dish'
require_relative 'models/comment'
require_relative 'models/user'
require_relative 'models/like'

#binding.pry


#examples using active record (rails extension)
#Dish.find(2) - returns object with id of 2
#Dish.count - number of dishes in hash

#create/update a dish
#D1 = Dish.new - to add name Dish.name = "pizza"
#then to save to db: d1.save - and it assigns id automatically

