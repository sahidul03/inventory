class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
    @employee.joining_date = Date.today
    @employee.date_of_birth = Date.today
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def create
    @employee=Employee.new(params_employee)
    if @employee.save
      flash[:notice] = "Employee added successfully."
      redirect_to employees_path
    else
      render 'new'
    end
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(params_employee)
      flash[:notice] = "Employee updated successfully."
      redirect_to employees_path
    else
      render 'new'
    end
  end

  def show
    @employee = Employee.find(params[:id])
    @employee_salaries = @employee.employee_salary_adds
    @employe_payments = @employee.employee_payments
    @payment_salary_combined_reports = @employee_salaries + @employe_payments
    @payment_salary_combined_reports = @payment_salary_combined_reports.sort_by(&:created_at)
    @leave_reports = EmployeeLeave.where(:employee_id => @employee.id)
  end

  def profile_picture_change
    @employee_photo=Employee.find(params[:employee_id])
    if @employee_photo.update(:profile_photo=> params[:employee][:profile_photo])
      if params[:employee][:profile_photo].present?
        @flag='true'
      end
    end
  end

  def cropped_profile_picture_save
    @employee_photo=Employee.find(params[:employee][:id])
    if @employee_photo.update!(params_cropped_profile_photo)
      @flag='true'
    end
  end

  def active
    employee = Employee.find(params[:employee][:id])
    if employee.update(:isActive=> !employee.isActive)
      if employee.isActive
        flash[:notice] = employee.name.to_s + " is activated"
      else
        flash[:notice] = employee.name.to_s + " is de-activated"
      end
      redirect_to employees_path
    else
      flash[:alert] = "Employee's active status is not changed"
    end
  end




  protected
  
  def params_employee
    params.require(:employee).permit(:name, :address, :gender, :date_of_birth, :joining_date, :leaving_date, :nationality,
                                     :qualification, :designation, :salary, :isActive, :contact_number, :skype_name, :email,
                                     :national_id_number, :work_experience).merge(:user_id => current_user.id)
  end

  def params_cropped_profile_photo
    params.require(:employee).permit(:profile_photo, :crop_x, :crop_y, :crop_w, :crop_h)
  end
  
end
