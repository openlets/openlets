module MonetaryModels
  module TimeBank
    module Economy
      extend ActiveSupport::Concern

      included do
        validates_presence_of :max_debit, :max_credit
      end

      module ClassMethods
      end
    end
  end
end