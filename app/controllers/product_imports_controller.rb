class ProductImportsController < ApplicationController

  def new
    @product_import = ProductImport.new
    @product_import.import_date = Date.today
  end

  def create
    @product_import = ProductImport.new(params_product_import)
    if @product_import.save
      # @product_import.update(:total_price => @product_import.quantity*@product_import.rate)
      StorageProductAdd.create(:product_color_id => @product_import.product_color_id, :product_type_id => @product_import.product_type_id, :user_id => current_user.id, :quantity => @product_import.quantity, :remarks => @product_import.remarks)
      if @product_import.convince + @product_import.labour_cost + @product_import.transport_cost > 0
        CashBalanceOut.create(:user_id => current_user.id, :amount => @product_import.convince+@product_import.labour_cost+@product_import.transport_cost, :remarks => @product_import.remarks, :to_whom => 'import cost', :flag => 5)
      end

      flash[:success] = 'Product imported successfully.'
      redirect_to new_product_import_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = ProductImport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html { render :layout => 'blank_layout' }
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
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = ProductImport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = ProductImport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = ProductImport.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:party_id => @party.id) if @party

  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = ProductImport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = ProductImport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = ProductImport.all
    end

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:party_id => @party.id) if @party

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
    @reports = ProductImport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html { render :layout => 'blank_layout' }
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @party = Party.find(params[:party_id]) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = ProductImport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:party_id => @party.id) if @party
  end

  def date_to_date_report_download
    @party = Party.find(params[:party_id]) rescue nil
    @product_type = ProductType.find(params[:product_type_id]) rescue nil
    @product_color = ProductColor.find(params[:product_color_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = ProductImport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:product_type_id => @product_type.id) if @product_type
    @reports = @reports.where(:product_color_id => @product_color.id) if @product_color
    @reports = @reports.where(:party_id => @party.id) if @party

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end



  protected
  def params_product_import
    params.require(:product_import).permit(:quantity, :rate, :convince, :labour_cost, :transport_cost, :car_number, :import_date, :remarks).merge(:product_color_id => params[:product_color_id], :product_type_id => params[:product_type_id], :party_id => params[:party_id], :user_id => current_user.id)
  end


end
