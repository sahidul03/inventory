class BankBalanceOutsController < ApplicationController

  def index

  end

  def new
    @bank_balance_out = BankBalanceOut.new
  end

  def create
    @bank_balance_out = BankBalanceOut.new(params_bank_balance_out)
    if @bank_balance_out.save
      flash[:notice] = 'Bank balance withdrawn successfully.'
      redirect_to new_bank_balance_out_path
    else
      render 'new'
    end
  end

  protected
  def params_bank_balance_out
    params.require(:bank_balance_out).permit(:to_whom, :amount, :remarks, :cheque_number).merge(:bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end


end
