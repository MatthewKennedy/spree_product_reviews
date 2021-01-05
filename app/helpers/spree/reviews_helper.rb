module Spree
  module ReviewsHelper
    def txt_stars(n, show_out_of = true)
      res = Spree.t(:star, count: n)
      res += " #{Spree.t('out_of_5')}" if show_out_of
      res
    end

    def last_star_percentage(product)
      result = (product.avg_rating.modulo(1)).round(1) * 100 || 0

      if result <= 0
        100
      else
        result
      end
    end

    def accurate_average(product)
      product.avg_rating.round(1) || 0
    end
  end
end
