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
      return image_url_with_host(@item.image) if @item && @item.image.present?
      return image_url_with_host(@wish.image) if @wish && @wish.image.present?
      return image_url_with_host(current_economy.big_logo)
    end
  end

  def image_url_with_host(image)
    "http://" + current_host + image.url
  end

end