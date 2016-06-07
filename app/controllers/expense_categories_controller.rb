class ExpenseCategoriesController < ApplicationController

  def index
    @expense_categories = ExpenseCategory.all
  end

  def new
    @expense_category = ExpenseCategory.new
  end

  def create
    @expense_category = ExpenseCategory.new(params_expense_category)
    if @expense_category.save
      flash[:notice] = "Expense category created successfully."
      redirect_to expense_categories_path
    else
      render 'new'
    end
  end

  def edit
    @expense_category = ExpenseCategory.find(params[:id])
  end

  def update
    @expense_category = ExpenseCategory.find(params[:id])
    if @expense_category.update(params_expense_category_update)
      flash[:notice] = "Expense category updated successfully."
      redirect_to expense_categories_path
    else
      render 'edit'
    end
  end


  protected
  def params_expense_category
    params.require(:expense_category).permit(:name, :isActive).merge(:user_id => current_user.id)
  end
  def params_expense_category_update
    params.require(:expense_category).permit(:name, :isActive)
  end
end
