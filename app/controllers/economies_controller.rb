class EconomiesController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  protected
    def begin_of_association_chain
      current_user
    end  
end