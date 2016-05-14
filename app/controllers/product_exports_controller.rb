class ProductExportsController < ApplicationController

  def new
    @product_export = ProductExport.new
    @product_export.export_date = Date.today
  end

  def create
    @product_export = ProductExport.new(params_product_export)
    if @product_export.save
      StorageProductOut.create(:product_color_id => @product_export.product_color_id, :product_type_id => @product_export.product_type_id, :user_id => current_user.id, :quantity => @product_export.quantity, :remarks => @product_export.remarks)
      if @product_export.total_cost > 0
        CashBalanceOut.create(:user_id => current_user.id, :amount => @product_export.total_cost, :remarks => @product_export.remarks, :to_whom => 'export cost')
      end
      flash[:success] = 'Product exported successfully.'
      redirect_to new_product_export_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = ProductExport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @buyer = Buyer.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = ProductExport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = ProductExport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = ProductExport.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:buyer_id => @buyer.id) if @buyer

  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @buyer = Buyer.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = ProductExport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = ProductExport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = ProductExport.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:buyer_id => @buyer.id) if @buyer

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
    @reports = ProductExport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html 
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @buyer = Buyer.find(params[:buyer_id]) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = ProductExport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:buyer_id => @buyer.id) if @buyer
  end

  def date_to_date_report_download
    @buyer = Buyer.find(params[:buyer_id]) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = ProductExport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:buyer_id => @buyer.id) if @buyer

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end



  protected
  def params_product_export
    params.require(:product_export).permit(:quantity, :rate, :CNF_bill, :shipping_bill, :labour_cost, :transport_cost, :car_number, :export_date, :remarks, :bag).merge(:product_color_id => params[:product_color_id], :product_type_id => params[:product_type_id], :buyer_id => params[:buyer_id], :user_id => current_user.id)
  end


end
