class Wish < ActiveRecord::Base
  include Transactionable

  has_many   :items

  def any_wish_propositions?
    items.any?
  end

end