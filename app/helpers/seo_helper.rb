module SeoHelper

  def meta_title
    current_economy ? current_economy.title : Setting[:app_name]
  end

end