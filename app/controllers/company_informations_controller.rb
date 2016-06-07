class CompanyInformationsController < ApplicationController

  def index
    @company_info = CompanyInformation.last
  end

  def edit
    @company_info = CompanyInformation.find(params[:id])
  end

  def update
    @company_info = CompanyInformation.find(params[:id])
    if @company_info.update(params_company_info)
      flash[:success] = 'Company information updated successfully.'
      redirect_to company_informations_path
    else
      render 'edit'
    end
  end

  protected

  def params_company_info
    params.require(:company_information).permit(:name, :short_name, :description, :email, :contact_number, :fax, :address)
  end
end
