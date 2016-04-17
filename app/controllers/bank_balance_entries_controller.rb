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

  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = BankBalanceEntry.where(:created_at => Date.today.at_beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  protected
  def params_bank_balance_entry
    params.require(:bank_balance_entry).permit(:from_where, :amount, :remarks).merge(:bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end

end
