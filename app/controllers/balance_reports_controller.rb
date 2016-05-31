class BalanceReportsController < ApplicationController


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @cash_reports = CashBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @bank_reports = BankBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @reports = @cash_reports + @bank_reports
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

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @cash_reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      @bank_reports = BankBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @cash_reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      @bank_reports = BankBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @cash_reports = CashBalanceEntry.all
      @bank_reports = BankBalanceEntry.all
    end

    @reports = @cash_reports + @bank_reports
    @reports = @reports.sort_by(&:created_at)

  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @cash_reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
      @bank_reports = BankBalanceEntry.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @cash_reports = CashBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
      @bank_reports = BankBalanceEntry.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @cash_reports = CashBalanceEntry.all
      @bank_reports = BankBalanceEntry.all
    end

    @reports = @cash_reports + @bank_reports
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
    @cash_reports = CashBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @bank_reports = BankBalanceEntry.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    @reports = @cash_reports + @bank_reports
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
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @cash_reports = CashBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    @bank_reports = BankBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @cash_reports + @bank_reports
    @reports = @reports.sort_by(&:created_at)

  end

  def date_to_date_report_download
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @cash_reports = CashBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    @bank_reports = BankBalanceEntry.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @cash_reports + @bank_reports
    @reports = @reports.sort_by(&:created_at)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

end
