class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
  
  #GET to /user/:user_id/profile/new 
  def new
    # Render a blank profile details form
    @profile = Profile.new  
  end 
  
  #POST request for a profile form
  def create
    # Ensure that we have the User id of the person filling the form
    @user = User.find(params[:user_id])
    #Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action: :new
    end 
  end 
  
  #Get requests made for editing profiles
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile 
  end
  
  #This happens when someone makes a PUT Request on the Profile Edit page. 
  def update
    #Retrieve the user from the database
    @user = User.find( params[:user_id] )
    #Retreive that user's profile
    @profile = @user.profile
    #Mass assign edited profile attributes and update
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated"
      #Redirect user to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end 
end