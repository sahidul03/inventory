class EmployeeLeavesController < ApplicationController

  def index
    @employee_leaves = EmployeeLeave.all.reverse_order

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def new
    @employee_leave = EmployeeLeave.new
    @employee_leave.start_date = Date.today
    @employee_leave.end_date = Date.today
  end

  def edit
    @employee_leave = EmployeeLeave.find(params[:id])
  end

  def create
    @employee_leave = EmployeeLeave.new(params_employee_leave)
    if @employee_leave.save
      flash[:notice] = "Leave added successfully."
      redirect_to employee_leaves_path
    else
      render 'new'
    end
  end

  def update
    @employee_leave = EmployeeLeave.find(params[:id])
    if @employee_leave.update(params_employee_leave)
      flash[:notice] = "Leave updated successfully."
      redirect_to employee_leaves_path
    else
      render 'new'
    end
  end

  def leave_search_according_to_employee
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @employee_leaves = EmployeeLeave.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?", @year_month.beginning_of_month, @year_month.end_of_month, @year_month.beginning_of_month, @year_month.end_of_month )
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @employee_leaves = EmployeeLeave.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?", @year_month.beginning_of_year, @year_month.end_of_year, @year_month.beginning_of_year, @year_month.end_of_year )
    else
      @employee_leaves = EmployeeLeave.all.reverse_order
    end

    @employee_leaves = @employee_leaves.where(:employee_id => @employee.id) if @employee
  end

  def leave_search_according_to_employee_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @employee = Employee.find(params[:employee_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @employee_leaves = EmployeeLeave.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?", @year_month.beginning_of_month, @year_month.end_of_month, @year_month.beginning_of_month, @year_month.end_of_month )
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @employee_leaves = EmployeeLeave.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?", @year_month.beginning_of_year, @year_month.end_of_year, @year_month.beginning_of_year, @year_month.end_of_year )
    else
      @employee_leaves = EmployeeLeave.all.reverse_order
    end

    @employee_leaves = @employee_leaves.where(:employee_id => @employee.id) if @employee

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  protected

  def params_employee_leave
    params.require(:employee_leave).permit(:start_date, :end_date, :remarks).merge(:user_id => current_user.id, :employee_id => params[:employee_id])
  end


end
