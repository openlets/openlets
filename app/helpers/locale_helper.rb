module LocaleHelper

  def locale_direction
    locale = I18n.locale = params[:locale] || (current_user.locale unless current_user.try(:locale).blank?) || I18n.default_locale
    locale.to_s == "he" ? "rtl" : "ltr"
  end

  def current_locale
    @locale ||= I18n.locale
  end

  def rtl?
    @rtl ||= current_locale == :he
  end

  def top_bar_direction
    @dir ||= current_locale == :he ? 'left' : 'right'
  end

  def top_bar_other_direction
    @other_dir ||= current_locale == :he ? 'right' : 'left'
  end  

end