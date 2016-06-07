class BuyerPaymentsController < ApplicationController

  def index

  end

  def new
    @buyer_payment = BuyerPayment.new
    @buyer_payment.payment_date = Date.today
  end

  def create
    @buyer_payment = BuyerPayment.new(params_buyer_payment)
    if @buyer_payment.save
      if @buyer_payment.bank_account
        BankBalanceEntry.create(:bank_account_id => @buyer_payment.bank_account_id, :user_id => current_user.id, :from_where => @buyer_payment.buyer.name, :remarks => @buyer_payment.remarks, :amount => @buyer_payment.amount, :flag => 1)
      else
        CashBalanceEntry.create(:user_id => current_user.id, :from_where => @buyer_payment.buyer.name, :remarks => @buyer_payment.remarks, :amount => @buyer_payment.amount, :flag => 1)
      end
      flash[:notice] = 'Buyer payment added successfully.'
      redirect_to new_buyer_payment_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = BuyerPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @buyer = Buyer.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = BuyerPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = BuyerPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = BuyerPayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @buyer
      @reports = @reports.where(:buyer_id => @buyer.id)
    end
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @buyer = Buyer.find(params[:buyer_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = BuyerPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = BuyerPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = BuyerPayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @buyer
      @reports = @reports.where(:buyer_id => @buyer.id)
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
    @start_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    @reports = BuyerPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @buyer = Buyer.find(params[:buyer_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = BuyerPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @buyer
      @reports = @reports.where(:buyer_id => @buyer.id)
    end
  end

  def date_to_date_report_download
    @buyer = Buyer.find(params[:buyer_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = BuyerPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @buyer
      @reports = @reports.where(:buyer_id => @buyer.id)
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
  def params_buyer_payment
    params.require(:buyer_payment).permit(:payment_date, :amount, :remarks, :invoice_number, :dollar_amount, :bank_charge, :payment_type).merge(:buyer_id => params[:buyer_id], :bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end

end
