module ApplicationHelper

  def curreny_name
    @currency_name ||= Setting[:currency_name]
  end

end