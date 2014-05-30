module SeoHelper

  def meta_title
    if current_economy
      return content_for(:meta_title) if content_for(:meta_title).present?
      return current_economy.seo_title if current_economy.seo_title.present?
      return current_economy.title if current_economy.title.present?
    else 
      Setting[:app_name]
    end
  end

  def image_for_sharing
    if current_economy
      return @item.image.url if @item && @item.image.present?
      return @wish.image.url if @wish && @wish.image.present?
      return current_economy.big_logo.url
    end
  end

end