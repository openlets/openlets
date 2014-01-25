class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :create, :read, :update, :destroy, to: :crud

    can :read,      Item
    can :index,     Item
    can :read,      Wish
    cannot :create, Item
    
    if user # logged in user
      can    :create,            Item
      can    :crud,              user.items        { |i| i.user == user }
      can    :pause,             user.items        { |i| i.active? }
      cannot :pause,             Item.paused       { true }
      can    :activate,          user.items.paused { true }
      cannot :activate,          Item.active       { |i| i.active? }
      can    :crud,              user.wishes       { |w| w.user == user }
      can    :fulfill,           Wish
      can    :create_wish_offer, Wish
      can    :create,            Wish
      can    :show,              User
      can    :crud,              user
    end

    if user and user.approved? 
      can    :purchase, Item.active { |i| i.user != user }
      cannot :purchase, user.items  { true }
      can    :fulfill,  Wish.active.not_mine(user) { |w| w.user != user }
      cannot :fulfill,  user.wishes { |w| w.user == user }
      can    :crud,     Conversation
      can    :crud,     Message
      can    :create,   Comment
      can    :view,     Comment
      can    :direct_transfer, User.all { |u| u != user }
      can    :transfer, User.all { |u| u != user }
    end

  end
end
