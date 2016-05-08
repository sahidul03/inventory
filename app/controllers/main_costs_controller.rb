class MainCostsController < ApplicationController

  def new
    @main_cost = MainCost.new
  end

  def expense_load_according_to_expense_category
    @expenses = []
    @expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expenses = @expense_category.expenses.where(:isActive => true) if @expense_category
  end

  def create
    @main_cost = MainCost.new(params_main_cost)
    if @main_cost.save
      to_whom = @main_cost.expense.name.to_s + ", " + @main_cost.expense_category.name.to_s
      if @main_cost.bank_account
        BankBalanceOut.create(:bank_account_id => @main_cost.bank_account_id, :user_id => current_user.id, :to_whom => to_whom , :cheque_number => @main_cost.cheque_number, :remarks => @main_cost.remarks, :amount => @main_cost.amount, :flag => 2)
      else
        CashBalanceOut.create(:user_id => current_user.id, :to_whom => to_whom , :remarks => @main_cost.remarks, :amount => @main_cost.amount, :flag => 2)
      end
      flash[:success] = 'Main cost added successfully.'
      redirect_to new_main_cost_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = MainCost.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expense = Expense.find(params[:expense_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = MainCost.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = MainCost.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = MainCost.all
    end

    if @expense_category
      @reports = @reports.where(:expense_category_id => @expense_category.id)
    end
    if @expense
      @reports = @reports.where(:expense_id => @expense.id)
    end
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expense = Expense.find(params[:expense_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = MainCost.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = MainCost.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = MainCost.all
    end

    if @expense_category
      @reports = @reports.where(:expense_category_id => @expense_category.id)
    end
    if @expense
      @reports = @reports.where(:expense_id => @expense.id)
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
    @start_date = @date
    @end_date = @date
    @reports = MainCost.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expense = Expense.find(params[:expense_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = MainCost.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if @expense_category
      @reports = @reports.where(:expense_category_id => @expense_category.id)
    end
    if @expense
      @reports = @reports.where(:expense_id => @expense.id)
    end
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
  end

  def date_to_date_report_download
    @expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expense = Expense.find(params[:expense_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = MainCost.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil

    if @expense_category
      @reports = @reports.where(:expense_category_id => @expense_category.id)
    end
    if @expense
      @reports = @reports.where(:expense_id => @expense.id)
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



  protected
  def params_main_cost
    params.require(:main_cost).permit(:amount, :remarks, :cheque_number).merge(:expense_category_id => params[:expense_category_id], :bank_account_id => params[:bank_account_id], :expense_id => params[:expense_id], :user_id => current_user.id)
  end

end
