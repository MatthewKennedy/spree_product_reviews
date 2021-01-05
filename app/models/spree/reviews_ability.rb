module Spree
  class ReviewsAbility
    include CanCan::Ability

    def initialize(user)
      review_ability_class = self.class
      can :create, Spree::Review do
        review_ability_class.allow_anonymous_reviews? || !user.email.blank?
      end
    end

    def self.allow_anonymous_reviews?
      !SpreeProductReviews::Config[:require_login]
    end
  end
end
