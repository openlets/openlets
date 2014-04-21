module SeoHelper

  def meta_title
    current_economy ? current_economy.title : "OpenLETS"
  end

end