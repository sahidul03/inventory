class AdminPermissionsController < ApplicationController

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

  def params_permission
    params.require(:admin_permission).permit(:super_admin, :admin_creation)
  end

end
