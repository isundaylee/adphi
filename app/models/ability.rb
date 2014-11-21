class Ability
  include CanCan::Ability

  def initialize(brother)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    unless brother.nil?
      can :read, Brother

      can :read, Meeting
      can :create, Meeting
      can :destroy, Meeting, creator_id: brother.id
      can :record, Meeting, creator_id: brother.id

      if brother.kitchen_manager?
        can :update, Balance, kind: "kitchen"
      end

      if brother.house_manager?
        can :update, Balance, kind: "house"
      end

      # TODO who manages social jobs?
      if false
        can :update, Balance, kind: "social"
      end
    end
  end
end
