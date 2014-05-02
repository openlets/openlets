module EconomyHelper

  def invite_only
    current_economy ? current_economy.invite_only : false
  end

end