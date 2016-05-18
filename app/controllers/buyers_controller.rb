class BuyersController < ApplicationController

  def index
    @buyers = Buyer.all
  end

  def new
    @buyer = Buyer.new
  end

  def show
    @buyer = Buyer.find(params[:id])
    @export_to_buyer = @buyer.product_exports
    @buyer_payments = @buyer.buyer_payments
    # @payment_export_combined_reports = @export_to_buyer + @buyer_payments
    # @payment_export_combined_reports = @payment_export_combined_reports.sort_by(&:created_at)
  end

  def create
    @buyer = Buyer.new(params_buyer)
    if @buyer.save
      flash[:notice] = "Buyer created successfully."
      redirect_to buyers_path
    else
      render 'new'
    end
  end

  def edit
    @buyer = Buyer.find(params[:id])
  end

  def update
    @buyer = Buyer.find(params[:id])
    if @buyer.update(params_buyer_update)
      flash[:notice] = "Buyer updated successfully."
      redirect_to buyers_path
    else
      render 'edit'
    end
  end

  protected
  def params_buyer
    params.require(:buyer).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive).merge(:user_id => current_user.id)
  end

  def params_buyer_update
    params.require(:buyer).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive)
  end

end
