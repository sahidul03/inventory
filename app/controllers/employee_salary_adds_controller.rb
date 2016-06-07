class EmployeeSalaryAddsController < ApplicationController

  def index

  end

  def new
    @employee_salary_add = EmployeeSalaryAdd.new
  end

  def create
    @employee_salary_add = EmployeeSalaryAdd.new(params_employee_salary_add)
    if @employee_salary_add.save
    flash[:notice] = 'Employee salary added successfully.'
      redirect_to new_employee_salary_add_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = EmployeeSalaryAdd.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = EmployeeSalaryAdd.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = EmployeeSalaryAdd.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = EmployeeSalaryAdd.all
    end

    @reports = @reports.where(:employee_id => @employee.id) if @employee
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = EmployeeSalaryAdd.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = EmployeeSalaryAdd.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = EmployeeSalaryAdd.all
    end

    @reports = @reports.where(:employee_id => @employee.id) if @employee

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
    @reports = EmployeeSalaryAdd.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = EmployeeSalaryAdd.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:employee_id => @employee.id) if @employee
  end

  def date_to_date_report_download
    @employee = Employee.find(params[:employee_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = EmployeeSalaryAdd.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)

    @reports = @reports.where(:employee_id => @employee.id) if @employee

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end



  protected
  def params_employee_salary_add
    params.require(:employee_salary_add).permit(:amount, :remarks,).merge(:employee_id => params[:employee_id], :user_id => current_user.id)
  end


end
