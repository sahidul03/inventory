class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|

      t.string :name
      t.boolean :isActive, default: true
      t.references :user, index: true
      t.references :expense_category, index: true

      t.timestamps null: false
    end
  end
end
