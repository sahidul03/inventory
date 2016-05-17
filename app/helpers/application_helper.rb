module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  def menu_class_active(c_name)
    if c_name == controller.controller_name
      return 'active'
    else
      return ''
    end
  end

  def sub_menu_class_active(path)
    if current_page? path
      return 'active'
    else
      return ''
    end
  end

  def expense_and_income_of_year(year)
    month_array = []
    monthly_expense_array = []
    monthly_income_array = []

    month = year.beginning_of_year
    end_date = year.end_of_year
    while end_date >= month do
      month_array << month.strftime("%B")
      single_monthly_expense = 0;
      single_monthly_income = 0;

      cash_expense = CashBalanceOut.where(:created_at => month.beginning_of_month..month.end_of_month)
      bank_expense = BankBalanceOut.where(:created_at => month.beginning_of_month..month.end_of_month)
      single_monthly_expense = single_monthly_expense + cash_expense.sum(:amount) if cash_expense.any?
      single_monthly_expense = single_monthly_expense + bank_expense.sum(:amount) if bank_expense.any?

      cash_income = CashBalanceEntry.where(:created_at => month.beginning_of_month..month.end_of_month)
      bank_income = BankBalanceEntry.where(:created_at => month.beginning_of_month..month.end_of_month)
      single_monthly_income = single_monthly_income + cash_income.sum(:amount) if cash_income.any?
      single_monthly_income = single_monthly_income + bank_income.sum(:amount) if bank_income.any?

      monthly_expense_array << single_monthly_expense
      monthly_income_array << single_monthly_income

      month = month.next_month
    end
    return {month_array: month_array, monthly_expense_array: monthly_expense_array, monthly_income_array: monthly_income_array}
  end

  def total_expense_and_income_of_year(year)
    year_expense = 0;
    year_income = 0;
    cash_expense = CashBalanceOut.where(:created_at => year.beginning_of_year..year.end_of_year)
    bank_expense = BankBalanceOut.where(:created_at => year.beginning_of_year..year.end_of_year)
    year_expense = year_expense + cash_expense.sum(:amount) if cash_expense.any?
    year_expense = year_expense + bank_expense.sum(:amount) if bank_expense.any?

    cash_income = CashBalanceEntry.where(:created_at => year.beginning_of_year..year.end_of_year)
    bank_income = BankBalanceEntry.where(:created_at => year.beginning_of_year..year.end_of_year)
    year_income = year_income + cash_income.sum(:amount) if cash_income.any?
    year_income = year_income + bank_income.sum(:amount) if bank_income.any?

    return { year_income: year_income, year_expense: year_expense }
  end



end
