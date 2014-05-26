module ItemsHelper

  def purchase_button_for(item)
    if current_economy.currency_type_is?(:time_bank)
      link_to t('common.purchase'), purchase_details_item_path(item), class: 'button radius right small'
    else
      link_to t('common.purchase'), purchase_item_path(item), class: 'button radius right small', method: :post, confirm: t('common.are_you_sure')
    end
  end

end