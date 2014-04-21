module MemberHelper

  def current_member
    if current_user
      @member ||= (current_economy ? current_user.memberships.where(economy_id: current_economy.id).first : current_user)
    end
  end

  def member_signed_in?
    # current_member.blank?
    current_user.memberships.map(&:economy_id).include?(current_economy.id)
  end

end