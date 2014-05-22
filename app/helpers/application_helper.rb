module ApplicationHelper

  def curreny_name
    @currency_name ||= current_economy.currency_name
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def top_bar_title
    link_to root_path do
      if current_economy 
        image_tag(current_economy.logo) || current_economy.title
      else 
        Setting[:app_name]
      end
    end
  end

  def economy_title
    current_economy.title || "Join our Economy!"
  end

  def economy_description
    current_economy.description || "Checkout all the great things you can trade on our marketplace"
  end

end