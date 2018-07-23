class User < ActiveRecord::Base
    has_secure_password
    # add a method - password
    # add another method - authenticate #user.authenticate('password') - returns true or false


end