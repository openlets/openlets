module MonetaryModels
  module TimeBank
    module Transaction
      extend ActiveSupport::Concern

      included do
        validate :sufficient_funds, :max_credit
      end

      def sufficient_funds
        errors.add :base, I18n.t('mutual_credit.validations.max_debit') if needed_funds < (economy.max_debit * 60)
      end

      def max_credit
        errors.add :base, I18n.t('mutual_credit.validations.max_credit') if balance_after_transaction > (economy.max_credit * 60)
      end

      def needed_funds
        sending_wallet.account_balance - amount
      end

      def balance_after_transaction
        receiving_wallet.account_balance + amount
      end

      module ClassMethods
      end
    end
  end
end