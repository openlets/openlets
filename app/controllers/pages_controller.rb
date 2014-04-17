class PagesController < ApplicationController

  def home
    @economies = Economy.all
  end

  def terms
  end

  def welcome
  end

end