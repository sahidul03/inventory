class AddDollarAmountBankChargePaymentTypeAndInvoiceNumberToBuyerPayments < ActiveRecord::Migration
  def change
    add_column :buyer_payments, :dollar_amount, :float, default: 0
    add_column :buyer_payments, :bank_charge, :float, default: 0
    add_column :buyer_payments, :payment_type, :string
    add_column :buyer_payments, :invoice_number, :string
    remove_column :buyer_payments, :cheque_number, :string
  end
end
