class Admin::MembersController < Admin::ResourceController

  before_filter :load_member, only: [:approve, :ban]

  def approve
    @member.approve!
    flash[:notice] = "Member has was approved"
    redirect_to admin_member_path(@member)
  end

  def ban
    @member.ban!
    flash[:notice] = "Member has was banned"
    redirect_to admin_member_path(@member)
  end

  private

    def load_member
      @member = Member.find(params[:member_id])
    end

    def collection
      if current_economy
        @collection ||= end_of_association_chain.filter_for(filter_params).where(economy_id: current_economy.id).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      else
        @collection ||= end_of_association_chain.filter_for(filter_params).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end 
    end

end