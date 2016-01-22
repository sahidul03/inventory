class CreateThemeCustomizations < ActiveRecord::Migration
  def change
    create_table :theme_customizations do |t|

      t.string :theme_color, default: 'blue'
      t.string :header_style, default: 'default'
      t.string :header_position, default: 'fixed'
      t.string :sidebar_style, default: 'default'
      t.string :sidebar_position, default: 'fixed'
      t.string :sidebar_gradient, default: 'disabled'
      t.string :content_style, default: 'default'

      t.timestamps null: false
    end
  end
end
