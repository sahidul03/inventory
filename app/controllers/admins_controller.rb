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
        AdminPermission.create(:user_id=>@user.id)
        flash[:notice] = "Admin created successfully."
        redirect_to admins_path
      else
        render 'new'
      end
  end

  def edit_permission
    @user=User.find(params[:id])
    if @user.admin_permission
       @permission=@user.admin_permission
    else
      @permission=AdminPermission.create(:user_id=>@user.id)
    end
  end

  protected

  def params_admin
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

end
