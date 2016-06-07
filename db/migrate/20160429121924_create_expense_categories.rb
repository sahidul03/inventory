class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|


      t.string :name
      t.boolean :isActive, default: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
