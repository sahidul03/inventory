class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    user=User.find_by_email(params[:user][:email]) rescue nil
    if user
      if user.is_active
        self.resource = warden.authenticate!(auth_options)
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash[:alert] = "You have not access to sign in."
        redirect_to :back
      end
    else
      flash[:alert] = "Wrong email or password."
      redirect_to :back
    end
  end

end
