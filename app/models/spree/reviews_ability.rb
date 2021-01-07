module Spree
  class ReviewsAbility
    include CanCan::Ability

    def initialize(user)
      can :create, Spree::Review do |_review|
        user.email.present?
      end
    end
  end
end
