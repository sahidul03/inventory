class PartiesController < ApplicationController

  def index
    @parties = Party.all
  end

  def new
    @party = Party.new
  end

  def show
    @party = Party.find(params[:id])
  end

  def create
    @party = Party.new(params_party)
    if @party.save
      flash[:notice] = "Party created successfully."
      redirect_to parties_path
    else
      render 'new'
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
    if @party.update(params_party_update)
      flash[:notice] = "Party updated successfully."
      redirect_to parties_path
    else
      render 'edit'
    end
  end

  protected
  def params_party
    params.require(:party).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive).merge(:user_id => current_user.id)
  end

  def params_party_update
    params.require(:party).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive)
  end

end
