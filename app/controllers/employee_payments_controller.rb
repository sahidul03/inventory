class EmployeePaymentsController < ApplicationController

  def index

  end

  def new
    @employee_payment = EmployeePayment.new
    @employee_payment.payment_date = Date.today
  end

  def create
    @employee_payment = EmployeePayment.new(params_employee_payment)
    if @employee_payment.save
      if @employee_payment.bank_account
        BankBalanceOut.create(:bank_account_id => @employee_payment.bank_account_id, :user_id => current_user.id, :to_whom => @employee_payment.employee.name, :cheque_number => @employee_payment.cheque_number, :remarks => @employee_payment.remarks, :amount => @employee_payment.amount, :flag => 3)
      else
        CashBalanceOut.create(:user_id => current_user.id, :to_whom => @employee_payment.employee.name, :remarks => @employee_payment.remarks, :amount => @employee_payment.amount, :flag => 3)
      end
      flash[:notice] = 'Employee payment added successfully.'
      redirect_to new_employee_payment_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = EmployeePayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = EmployeePayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = EmployeePayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = EmployeePayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @employee
      @reports = @reports.where(:employee_id => @employee.id)
    end
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = EmployeePayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = EmployeePayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = EmployeePayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @employee
      @reports = @reports.where(:employee_id => @employee.id)
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
    @reports = EmployeePayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @employee = Employee.find(params[:employee_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = EmployeePayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @employee
      @reports = @reports.where(:employee_id => @employee.id)
    end
  end

  def date_to_date_report_download
    @employee = Employee.find(params[:employee_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = EmployeePayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @employee
      @reports = @reports.where(:employee_id => @employee.id)
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
  def params_employee_payment
    params.require(:employee_payment).permit(:payment_date, :amount, :remarks, :cheque_number).merge(:employee_id => params[:employee_id], :bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end

end
