module Paramable
  extend ActiveSupport::Concern

  included do
    attr_accessor :params, :current_economy
  end

end