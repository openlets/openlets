class PagesController < ApplicationController

  def home
    @economies = Economy.all
  end

  def terms
  end

  def welcome
  end

  def economy_home
    filter_params
    set_filter_param('economy_id', current_economy.id) if current_economy
    @items = Item.filter_for(filter_params)
  end

end