class PagesController < ApplicationController
  def terms
  end

  def welcome
  end

  def home
    @items = Item.of_approved_users.active
  end

end