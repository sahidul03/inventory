class CreateMainCosts < ActiveRecord::Migration
  def change
    create_table :main_costs do |t|

      t.float :amount, default: 0
      t.text :remarks

      t.references :user, index: true
      t.references :expense_category, index: true
      t.references :expense, index: true

      t.timestamps null: false
    end
  end
end
