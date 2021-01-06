# Add access to reviews/ratings to the product model
module Spree
  module ProductDecorator
    def self.prepended(base)
      base.has_many :reviews
    end

    def stars
      if avg_rating.nil?
        0
      elsif (avg_rating.modulo(1).round(1) * 100) == 0
        avg_rating.floor
      else
        avg_rating.ceil
      end
    end

    def recalculate_rating
      self[:reviews_count] = reviews.reload.approved.count
      self[:avg_rating] = if reviews_count > 0
        reviews.approved.sum(:rating).to_f / reviews_count
      else
        0
      end
      save
    end

    ::Spree::Product.prepend self if ::Spree::Product.included_modules.exclude?(self)
  end
end
