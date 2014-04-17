class RegistrationsController < Devise::RegistrationsController
  after_filter :create_member, only: :create

  private

    def create_member
      binding.pry
      current_economy.users << @user if current_economy && !current_economy.users.include?(@user)
    end

end