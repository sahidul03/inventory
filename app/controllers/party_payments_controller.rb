class PartyPaymentsController < ApplicationController

  def index

  end

  def new
    @party_payment = PartyPayment.new
    @party_payment.payment_date = Date.today
  end

  def create
    @party_payment = PartyPayment.new(params_party_payment)
    if @party_payment.save
      if @party_payment.bank_account
        BankBalanceOut.create(:bank_account_id => @party_payment.bank_account_id, :user_id => current_user.id, :to_whom => @party_payment.party.name, :cheque_number => @party_payment.cheque_number, :remarks => @party_payment.remarks, :amount => @party_payment.amount)
      end
      flash[:notice] = 'Party payment added successfully.'
      redirect_to new_party_payment_path
    else
      render 'new'
    end
  end


  def monthly_and_yearly_report
    @date = Date.today
    @month = Month.find(@date.strftime("%-m").to_i) rescue nil
    @year= Year.find_by_name(@date.strftime("%Y").to_s) rescue nil
    @reports = PartyPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

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
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = PartyPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = PartyPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = PartyPayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @party
      @reports = @reports.where(:party_id => @party.id)
    end
  end

  def monthly_and_yearly_report_download
    @month = Month.find(params[:month_id].to_i) rescue nil
    @year= Year.find_by_name(params[:year_id].to_s) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @party = Party.find(params[:party_id]) rescue nil

    if params[:month_id] !='' && params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i ,params[:month_id].to_i)
      @reports = PartyPayment.where(:created_at => @year_month.beginning_of_month..@year_month.end_of_month)
    elsif params[:year_id] != ''
      @year_month= DateTime.new( params[:year_id].to_i)
      @reports = PartyPayment.where(:created_at => @year_month.beginning_of_year..@year_month.end_of_year)
    else
      @reports = PartyPayment.all
    end

    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @party
      @reports = @reports.where(:party_id => @party.id)
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
    @reports = PartyPayment.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)

    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def date_to_date_report_search
    @party = Party.find(params[:party_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = PartyPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @party
      @reports = @reports.where(:party_id => @party.id)
    end
  end

  def date_to_date_report_download
    @party = Party.find(params[:party_id]) rescue nil
    @bank_account = BankAccount.find(params[:bank_account_id]) rescue nil
    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @reports = PartyPayment.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
    if @bank_account
      @reports = @reports.where(:bank_account_id => @bank_account.id)
    end
    if @party
      @reports = @reports.where(:party_id => @party.id)
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
  def params_party_payment
    params.require(:party_payment).permit(:payment_date, :amount, :remarks, :cheque_number).merge(:party_id => params[:party_id], :bank_account_id => params[:bank_account_id], :user_id => current_user.id)
  end

end
