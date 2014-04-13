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

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def top_bar_title
    link_to root_path do
      current_economy ? current_economy.title : 'OpenLETS'
    end
  end

end