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


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    payments = BuyerPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    exports = ProductExport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def monthly_and_yearly_report_search
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @buyer = Buyer.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      payments = BuyerPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      exports = ProductExport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      payments = BuyerPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      exports = ProductExport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      payments = BuyerPayment.all
      exports = ProductExport.all
    end

    if @buyer
      payments = payments.where(:buyer_id => @buyer.id)
      exports = exports.where(:buyer_id => @buyer.id)
    end

    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @buyer = Party.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      payments = BuyerPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      exports = ProductExport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      payments = BuyerPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      exports = ProductExport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      payments = BuyerPayment.all
      exports = ProductExport.all
    end

    if @buyer
      payments = payments.where(:buyer_id => @buyer.id)
      exports = exports.where(:buyer_id => @buyer.id)
    end

    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report
    @date = Date.today
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    payments = BuyerPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    exports = ProductExport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @buyer = Party.find(params[:buyer_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])

    payments = BuyerPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    exports = ProductExport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    if @buyer
      payments = payments.where(:buyer_id => @buyer.id)
      exports = exports.where(:buyer_id => @buyer.id)
    end
    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)
  end

  def date_to_date_report_download
    @buyer = Party.find(params[:buyer_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])

    payments = BuyerPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    exports = ProductExport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    if @buyer
      payments = payments.where(:buyer_id => @buyer.id)
      exports = exports.where(:buyer_id => @buyer.id)
    end
    @reports = payments + exports
    @reports = @reports.sort_by(&:created_at)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
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
