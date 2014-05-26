module LocaleHelper

  def locale_direction
    I18n.locale.to_s == "he" ? "rtl" : "ltr"
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