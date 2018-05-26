class UsersController < ApplicationController
  
  #When GET Request is sent for /users/:id
  def show
    @user = User.find( params[:id] )
  end
end 