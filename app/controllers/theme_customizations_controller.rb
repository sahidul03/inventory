class ThemeCustomizationsController < ApplicationController

  def edit_theme

    sidebar_gradient = {'1'=>'disabled','2'=>'enabled'}
    header_style = {'1'=>'default','2'=>'inverse'}
    header_position = {'1'=>'fixed','2'=>'default'}
    sidebar_position = {'1'=>'fixed','2'=>'default'}
    sidebar_style = {'1'=>'default','2'=>'grid'}
    content_style = {'1'=>'default','2'=>'black'}
    sidebar_color = {'1'=>'default','2'=>'lighter'}

    if ThemeCustomization.last
       ThemeCustomization.last.update(:theme_color=> params[:theme_color],:header_style=> header_style[params[:header_style]], :header_position=> header_position[params[:header_position]], :sidebar_style=> sidebar_style[params[:sidebar_style]], :sidebar_position=> sidebar_position[params[:sidebar_position]], :sidebar_gradient=> sidebar_gradient[params[:sidebar_gradient]], :content_style=> content_style[params[:content_style]], :sidebar_color=> sidebar_color[params[:sidebar_color]])
    end

  end

end
