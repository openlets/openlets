module LocaleHelper

  def locale_direction
    locale = I18n.locale = params[:locale] || (current_user.locale unless current_user.try(:locale).blank?) || I18n.default_locale
    locale.to_s == "he" ? "rtl" : "ltr"
  end

end