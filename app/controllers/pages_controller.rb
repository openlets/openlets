class PagesController < ApplicationController

  def home
    @economies = Economy.all
  end

  def terms
  end

  def welcome
  end

  def faq
    
  end

  def economy_home
    @items = current_economy.items.filter_for(filter_params).active.of_approved_members.order("updated_at desc")
  end

end