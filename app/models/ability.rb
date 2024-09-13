class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.librarian?
      can :manage, Book
      can :manage, Borrowing
    end

    if user.member?
      can :read, Book
      can :create, Borrowing
      can [ :read, :update ], Borrowing, user_id: user.id
      can :search, Book
    end
  end
end
