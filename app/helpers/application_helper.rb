module ApplicationHelper

  def curreny_name
    @currency_name ||= Setting[:currency_name]
  end

  def rtl?
    I18n.locale == :he
  end

  def current_locale
    I18n.locale
  end

  def top_bar_direction
    I18n.locale == :he ? 'left' : 'right'
  end

end