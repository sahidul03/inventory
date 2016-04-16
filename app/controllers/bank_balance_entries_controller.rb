class BankBalanceEntriesController < ApplicationController

  def index

  end

  def new
    @bank_balance_entry = BankBalanceEntry.new
  end

  def create
    @bank_balance_entry = BankBalanceEntry.new(params_bank_balance_entry)
    if @bank_balance_entry.save
      flash[:notice] = 'Bank balance added successfully.'
      redirect_to new_bank_balance_entry_path
    else
      render 'new'
    end
  end

  protected
  def params_bank_balance_entry
    params.require(:bank_balance_entry).permit(:from_where, :amount, :remarks).merge(:bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end

end
