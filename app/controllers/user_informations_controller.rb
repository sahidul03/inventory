class UserInformationsController < ApplicationController

  def edit
    @user_information=UserInformation.find(params[:id])
  end

  def update
    @user_information=UserInformation.find(params[:id])
    if @user_information.update(params_user_information)
      flash[:notice] = "User information updated successfully."
      redirect_to user_information_path(@user_information)
    else
      render 'edit'
    end
  end

  def show
    @user_information=UserInformation.find(params[:id])
  end

  def profile_picture_change
    @user_info=UserInformation.find(params[:user_info_id])
    if @user_info.update(:profile_photo=> params[:user_information][:profile_photo])
      if params[:user_information][:profile_photo].present?
        @flag='true'
      end
    end
  end

  protected
  def params_user_information
    params.require(:user_information).permit(:first_name, :last_name, :profile_photo, :gender, :address, :nationality, :date_of_birth, :religion, :contact_number, :language, :designation).merge(:user_id => current_user.id)
  end

end
