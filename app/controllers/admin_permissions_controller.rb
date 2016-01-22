class AdminPermissionsController < ApplicationController

  before_action :is_permitted

  def edit
    @permission=AdminPermission.find(params[:id])
  end

  def update
    @permission=AdminPermission.find(params[:id])
    if @permission.update(params_permission)
      flash[:notice] = "Permissions are updated."
      redirect_to admins_path
    else
      render 'edit'
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

  def params_permission
    params.require(:admin_permission).permit(:super_admin, :admin_creation)
  end

end
