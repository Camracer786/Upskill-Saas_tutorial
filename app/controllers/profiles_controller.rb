class ProfilesController < ApplicationController
  
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
      redirect_to user_path(params[:user_id])
    else
      render action: :new
    end 
  end 
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end