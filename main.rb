     
require 'sinatra'
#require "sinatra/reloader" #reloader only reloads this file by default
require 'pg'
require 'pry'

def run_sql(sql)
  conn = PG.connect(dbname: 'goodfoodhunting')
  result = conn.exec(sql) #always returns an array
  conn.close
  return result
end

require_relative 'db_config'
require_relative 'models/dish'
require_relative 'models/comment'
require_relative 'models/user'
require_relative 'models/like'

enable :sessions

helpers do  #creates methods that views can use
  def current_user 
    User.find_by(id: session[:user_id])
  end

  def logged_in?  #either get a user object or nil
    if current_user
      true
    else
      false
    end
    #could write as:
   # !!current_user
  end


end


get '/' do
  @dishes = Dish.all
  erb :index
end

  #getting the form to add a new dish
get '/dishes/new' do
  erb :new
end

  #show single dish by id
get '/dishes/:id' do
  # sql = "SELECT * FROM dishes WHERE id = #{params[:id]};"
  # result = run_sql(sql) #always returns something similar to an array
  # @dish = result.first
  # @comments = run_sql("SELECT * FROM comments WHERE dish_id = '#{params[:id]}';")

  @dish = Dish.find( params[:id] ) #find is always by id
  @comments = @dish.comments
  erb :dish_details
end


#create a dish
post '/dishes' do  #post can be dangerous as if can make multiple records if user refresses - need to redirect/change route
  #how? inputs from the form
  # sql = "INSERT INTO dishes (name, image_url) VALUES ('#{params[:name] }','#{params[:image_url]}');" #params from the form (new.erb)
  # run_sql(sql) 
  dish = Dish.new
  dish.name = params[:name] #grabs params from the form
  dish.image_url = params[:image_url]
  dish.save
  redirect '/' #get post redirect - needs to be a route
  
end

#delete a dish
delete '/dishes/:id' do
  # sql = "DELETE FROM dishes WHERE id= #{params[:id]};" 
  # run_sql(sql)
  dish = Dish.find( params[:id]) #finds dish
  dish.destroy #deletes the dish
  redirect '/'
end


#update dish: get the dish
get '/dishes/:id/edit' do
#  result = run_sql("SELECT * FROM dishes WHERE id = #{params[:id]};")
#  @dish = result.first
@dish = Dish.find(params[:id])
 erb :edit
end

#push details and redirect- updates the dish
put '/dishes/:id' do
  # sql = "UPDATE dishes SET name = '#{params[:name]}', image_url = '#{params[:image_url]}' WHERE id = '#{params[:id]}';" #params from the form
  # run_sql(sql)
  dish = Dish.find(params[:id])
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save
  redirect "/dishes/#{params[:id]}"
end


post '/comments' do
  redirect '/login' unless logged_in?
  # sql = "INSERT INTO comments (content, dish_id) VALUES ('#{params[:content]}', #{params[:dish_id] } );"
  # run_sql(sql)
  comment = Comment.new
  comment.content = params[:content]
  comment.dish_id = params[:dish_id]
  comment.save

  redirect "/dishes/#{params[:dish_id] }"
end



#creates a logged in session if details are correct
get '/login' do 
  erb :login
end

post '/session' do
  #grab email/password from the form at '/login'
  #find the user by email
  user = User.find_by(email: params[:email])
  #authenticate user with password
  if user && user.authenticate(params[:password])
    #create new session
    session[:user_id] = user.id
     #redirect to secret page
    redirect '/'
  else 
    erb :login
  end
end


delete '/session' do
  #delete the session
  session[:user_id] = nil
  #redirect to login page
  redirect '/login'
end

post '/likes' do
    redirect '/login' unless logged_in?
    #insert a record into the likes table
    #creating a like
    like = Like.new
    like.dish_id = params[:dish_id]
    like.user_id = current_user.id
    like.save

    redirect "/dishes/#{params[:dish_id]}"
end