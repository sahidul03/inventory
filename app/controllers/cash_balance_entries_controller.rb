class CashBalanceEntriesController < ApplicationController

  def index

  end

  def new
    @cash_balance_entry = CashBalanceEntry.new
  end

  def create
    @cash_balance_entry = CashBalanceEntry.new(params_cash_balance_entry)
    if @cash_balance_entry.save
      flash[:notice] = 'Cash balance added successfully.'
      redirect_to new_cash_balance_entry_path
    else
      render 'new'
    end
  end

  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = CashBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = CashBalanceEntry.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = CashBalanceEntry.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
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
    @reports = CashBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = CashBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
  end

  def date_to_date_report_download
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = CashBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end


  protected
  def params_cash_balance_entry
    params.require(:cash_balance_entry).permit(:from_where, :amount, :remarks).merge(:user_id => current_user.id)
  end

end
