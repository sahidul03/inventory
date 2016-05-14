class AddTransportCostAndTotalCostToProductImports < ActiveRecord::Migration
  def change
    add_column :product_imports, :transport_cost, :float, default: 0
    add_column :product_imports, :total_cost, :float, default: 0
  end
end
