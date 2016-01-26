class AddSidebarColorToThemeCustomizations < ActiveRecord::Migration
  def change
    add_column :theme_customizations, :sidebar_color, :string, defeault: 'default'
  end
end
