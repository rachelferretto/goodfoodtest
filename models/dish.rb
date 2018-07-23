class Dish < ActiveRecord::Base
    has_many :comments #has_many is a built in active method  .comments on a dish will return all the comments on that dish
    belongs_to :user # in app console - gives an additional method .user, to get all the associated user detail
    has_many :likes # adds the like method, can do Dish.likes
end