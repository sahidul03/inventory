class AdminsController < ApplicationController

  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(params_admin)
      if @user.save
        flash[:notice] = "Admin created successfully."
        redirect_to admins_path
      else
        render 'new'
      end
  end

  protected

  def params_admin
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

end
