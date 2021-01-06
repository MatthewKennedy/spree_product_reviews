module Spree
  module ReviewsHelper
    def txt_stars(n, show_out_of = true)
      res = Spree.t(:star, count: n)
      res += " #{Spree.t(:out_of_5)}" if show_out_of
      res
    end

    def last_star_percentage(product)
      result = (product.avg_rating.modulo(1)).round(1) * 100

      if result <= 0
        100
      else
        result
      end
    end

    def accurate_average(product)
      product.avg_rating.round(1) || 0
    end

    private

    def structured_product_hash(product)
      Rails.cache.fetch(common_product_cache_keys + ["spree/structured-data/#{product.cache_key_with_version}"]) do
        {
          '@context': "https://schema.org/",
          '@type': "Product",
          '@id': "#{spree.root_url}product_#{product.id}",
          url: spree.product_url(product),
          name: product.name,
          image: structured_images(product),
          description: product.description,
          sku: structured_sku(product),
          gtin13: product.property("GTIN"),
          brand: product.property("Brand"),

          review: {
            "@type": "Review",

            reviewRating: {
              "@type": "Rating",
              ratingValue: structured_review_rating(product)
            },

            author: {
              "@type": "Person",
              name: structured_review_name(product)
            },

            reviewBody: structured_review_content(product)

          },
          aggregateRating: {
            ratingValue: accurate_average(product),
            bestRating: SpreeProductReviews::Config.number_of_stars,
            worstRating: 0,
            ratingCount: product.reviews_count
          },

          offers: {
            '@type': "Offer",
            price: product.default_variant.price_in(current_currency).amount,
            priceCurrency: current_currency,
            availability: product.in_stock? ? "InStock" : "OutOfStock",
            url: spree.product_url(product),
            availabilityEnds: product.discontinue_on ? product.discontinue_on.strftime("%F") : ""
          }
        }
      end
    end

    def structured_review_name(product)
      if product.reviews.default_approval_filter.latest.empty?
        "This product has no review"
      else
        product.reviews.default_approval_filter.latest[0][:name]
      end
    end

    def structured_review_content(product)
      if product.reviews.default_approval_filter.latest.empty?
        "This product has no review"
      else
        product.reviews.default_approval_filter.latest[0][:review]
      end
    end

    def structured_review_rating(product)
      if product.reviews.default_approval_filter.latest.empty?
        0
      else
        product.reviews.default_approval_filter.latest[0][:rating]
      end
    end
  end
end
