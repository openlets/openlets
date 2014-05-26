module MonetaryModels
  module MutualCredit
    module Item
      extend ActiveSupport::Concern

      included do
        validates_presence_of :price
        validates_numericality_of :price
      end
      
      module ClassMethods
      end
    end
  end
end