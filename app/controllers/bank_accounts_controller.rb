class BankAccountsController < ApplicationController

  def index
    @bank_accounts = BankAccount.all
  end

  def show
    @bank_account = BankAccount.find(params[:id])
  end

  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    if @bank_account.save
      flash[:notice] = 'Bank Account created successfully.'
      redirect_to bank_account_path(@bank_account)
    else
      render 'new'
    end
  end

  def edit
    @bank_account = BankAccount.find(params[:id])
  end

  def update
    @bank_account = BankAccount.find(params[:id])
    if @bank_account.update(bank_account_params_update)
      flash[:notice] = 'Bank Account updated successfully.'
      redirect_to bank_account_path(@bank_account)
    else
      render 'edit'
    end
  end

  private
  def bank_account_params
    params.require(:bank_account).permit(:bank_name, :branch_name, :account_name, :account_number, :account_type,
                                         :isActive, :details).merge(:user_id => current_user.id)
  end
  def bank_account_params_update
    params.require(:bank_account).permit(:bank_name, :branch_name, :account_name, :account_number, :account_type,
                                         :isActive, :details)
  end

end
