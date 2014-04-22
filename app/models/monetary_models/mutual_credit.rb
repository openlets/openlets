module MonetaryModels
  module MutualCredit
    extend ActiveSupport::Concern

    included do
      validate :sufficient_funds
    end

    def sufficient_funds
      errors.add :base, "insufficient funds" if needed_funds < economy.max_debit
    end

    def needed_funds
      sending_wallet.account_balance - amount
    end

    module ClassMethods
    end

  end
end