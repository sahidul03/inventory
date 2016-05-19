class PartiesController < ApplicationController

  def index
    @parties = Party.all
  end

  def new
    @party = Party.new
  end

  def show
    @party = Party.find(params[:id])
    @imports_from_party = @party.product_imports
    @party_payments = @party.party_payments
    # @payment_import_combined_reports = @imports_from_party + @party_payments
    # @payment_import_combined_reports = @payment_import_combined_reports.sort_by(&:created_at)
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


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    payments = PartyPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    imports = ProductImport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @reports = payments + imports
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
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      payments = PartyPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      imports = ProductImport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      payments = PartyPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      imports = ProductImport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      payments = PartyPayment.all
      imports = ProductImport.all
    end

    if @party
      payments = payments.where(:party_id => @party.id)
      imports = imports.where(:party_id => @party.id)
    end

    @reports = payments + imports
    @reports = @reports.sort_by(&:created_at)
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      payments = PartyPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      imports = ProductImport.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      payments = PartyPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      imports = ProductImport.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      payments = PartyPayment.all
      imports = ProductImport.all
    end

    if @party
      payments = payments.where(:party_id => @party.id)
      imports = imports.where(:party_id => @party.id)
    end

    @reports = payments + imports
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
    payments = PartyPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    imports = ProductImport.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @reports = payments + imports
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
    @party = Party.find(params[:party_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])

    payments = PartyPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    imports = ProductImport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    if @party
      payments = payments.where(:party_id => @party.id)
      imports = imports.where(:party_id => @party.id)
    end
    @reports = payments + imports
    @reports = @reports.sort_by(&:created_at)
  end

  def date_to_date_report_download
    @party = Party.find(params[:party_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])

    payments = PartyPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    imports = ProductImport.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    if @party
      payments = payments.where(:party_id => @party.id)
      imports = imports.where(:party_id => @party.id)
    end
    @reports = payments + imports
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
  def params_party
    params.require(:party).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive).merge(:user_id => current_user.id)
  end

  def params_party_update
    params.require(:party).permit(:name, :address, :photo, :contact_number, :fax, :email, :account_no, :skype_name, :company_name, :country, :isActive)
  end

end
