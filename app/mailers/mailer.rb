class Mailer < ActionMailer::Base
  default from: "info@openlets.org"

  def item_purchased(item, buyer, transaction)
  	@item = item
  	@buyer = buyer
  	mail(to: @item.user.email, subject: "#{buyer.full_name} just purchased your item - #{item.title}")
  end

  def wish_fulfilled(item)
    @item = item
    @wish = item.wish
    @wisher = @wish.user
    mail(to: @wisher.email, subject: "#{item.user.full_name} just offered to fulfill your wish - #{@wish.title}")
  end

  def new_message(message)
    @message  = message
    @receiver = message.conversation.other_user(message.user)
    mail(to: @receiver.email, subject: "#{message.user.full_name} just sent you a message")
  end

end