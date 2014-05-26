module EconomyHelper

  def invite_only
    current_economy ? current_economy.invite_only : false
  end

  def currency_name
    current_economy.time_bank? ? t('activerecord.attributes.economy.time_bank.currency_name') : current_economy.currency_name
  end

end