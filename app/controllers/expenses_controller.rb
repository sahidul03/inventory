class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params_expense)
    if @expense.save
      flash[:notice] = "Expense created successfully."
      redirect_to expenses_path
    else
      render 'new'
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(params_expense_update)
      flash[:notice] = "Expense updated successfully."
      redirect_to expenses_path
    else
      render 'edit'
    end
  end

  def search_expenses_by_category
    expense_category = ExpenseCategory.find(params[:expense_category_id]) rescue nil
    @expenses = Expense.all
    if expense_category
      @expenses = expense_category.expenses
    end
  end

  protected
  def params_expense
    params.require(:expense).permit(:name, :isActive).merge(:user_id => current_user.id, :expense_category_id => params[:expense_category_id])
  end
  def params_expense_update
    params.require(:expense).permit(:name, :isActive).merge( :expense_category_id => params[:expense_category_id])
  end
end
