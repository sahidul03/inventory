class CashBalanceOutsController < ApplicationController
  def index

  end

  def new
    @cash_balance_out = CashBalanceOut.new
  end

  def create
    @cash_balance_out = CashBalanceOut.new(params_cash_balance_out)
    if @cash_balance_out.save
      flash[:notice] = 'Cash balance withdrawn successfully.'
      redirect_to new_cash_balance_out_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = CashBalanceOut.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = CashBalanceOut.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = CashBalanceOut.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = CashBalanceOut.all
    end

  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = CashBalanceOut.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = CashBalanceOut.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = CashBalanceOut.all
    end

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
    @reports = CashBalanceOut.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = CashBalanceOut.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

  end

  def date_to_date_report_download
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = CashBalanceOut.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    
    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end



  protected
  def params_cash_balance_out
    params.require(:cash_balance_out).permit(:to_whom, :amount, :remarks).merge( :user_id => current_user.id)
  end
end
