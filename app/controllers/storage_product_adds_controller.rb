class StorageProductAddsController < ApplicationController

  def new
    @storage_product_add = StorageProductAdd.new
  end

  def create
    @storage_product_add = StorageProductAdd.new(params_storage_product_add)
    if @storage_product_add.save
      flash[:success] = 'Product added to storage successfully.'
      redirect_to new_storage_product_add_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = StorageProductAdd.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = StorageProductAdd.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = StorageProductAdd.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = StorageProductAdd.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color

  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = StorageProductAdd.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = StorageProductAdd.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = StorageProductAdd.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color

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
    @start_date = @date
    @end_date = @date
    @reports = StorageProductAdd.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = StorageProductAdd.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
  end

  def date_to_date_report_download
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = StorageProductAdd.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end



  protected
  def params_storage_product_add
    params.require(:storage_product_add).permit(:quantity, :remarks).merge(:product_color_id => params[:product_color_id], :product_type_id => params[:product_type_id], :user_id => current_user.id)
  end


end
