class WishesController < ApplicationController
	load_and_authorize_resource
	before_filter :load_wish, :only => [:show, :create_wish_offer, :fulfill]

	def new
		@wish = current_user.wishes.new
	end

	def create
		@wish = current_user.wishes.new(params[:wish])
		if @wish.save 
			redirect_to @wish
		else 
			render 'new'
		end
	end

	def close
		@wish.close!
		redirect_to @wish	
	end

	def show
	end

	def index
		@wishes = Wish.of_approved_users.active - current_user.wishes
	end

	def edit
		@wish = current_user.wishes.find(params[:id])
	end

	def update
		@wish = current_user.wishes.find(params[:id])
		if @wish.update_attributes(params[:wish])
			redirect_to @wish
		else
			render 'edit'
		end
	end

	def fulfill
		@item = current_user.items.new(title: @wish.title, image: @wish.image.url, 
														description: @wish.description, wish_id: @wish.id)
	end

	def create_wish_offer
    @item = current_user.items.new(params[:item])
    @item.wish_id = params[:id]
    @item.image = @wish.image unless @item.image.present?
    if @item.save
      flash[:notice] = "Created item successfuly"
      Mailer.wish_fulfilled(@item).deliver
      redirect_to @item
    else
      render 'fulfill'
    end		
	end

	private

		def load_wish
			@wish = Wish.find(params[:id])
		end

end
