class PagesController < ApplicationController

  def home
    @economies = Economy.all
  end

  def terms
  end

  def welcome
  end

  def economy_home
    @items = Item.filter_for(filter_params).active
    @items = @items.of_approved_members
    @items = @items.by_economy_id(current_economy.id) if current_economy
  end

end