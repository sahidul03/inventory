class AdminsController < ApplicationController

   before_action :is_permitted

  def index
    @users=User.where(:user_type => 0)
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(params_admin)
      if @user.save
        AdminPermission.create(:user_id=>@user.id)
        UserInformation.create(:user_id=>@user.id)
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

  def active
    user = User.find(params[:user][:id])
    if user.update(:is_active=> !user.is_active)
      if user.is_active
        flash[:notice] = user.email.to_s + " is activated"
      else
        flash[:notice] = user.email.to_s + " is de-activated"
      end
      redirect_to admins_path
    else
      flash[:alert] = 'Admin status is not changed'
    end
  end

  protected

  def is_permitted
    if user_signed_in?
       if current_user.user_type==1 || current_user.admin_permission.super_admin || current_user.admin_permission.admin_creation
       else
         redirect_to root_path
       end
    end
  end

  def params_admin
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

end
