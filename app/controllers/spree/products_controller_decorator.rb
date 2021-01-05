module Spree
  module ProductsControllerDecorator
    def self.prepended(base)
      base.helper Spree::ReviewsHelper
    end

    ::Spree::ProductsController.prepend self if ::Spree::ProductsController.included_modules.exclude?(self)
  end
end
