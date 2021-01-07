module SpreeProductReviews
  class Configuration < Spree::Preferences::Configuration
    ########################################################
    # These Setting are avalable in the admin UI
    ########################################################

    # Include non-approved reviews in (public) listings.
    preference :include_unapproved_reviews, :boolean, default: false

    # Control how many reviews are shown in summaries.
    preference :preview_size, :integer, default: 3

    # Whether to keep track of the reviewer's locale.
    preference :track_locale, :boolean, default: false

    ############################################################
    # Set the preferences below in the spree.rb initializer file
    ############################################################
    # How many star rating
    preference :number_of_stars, :integer, default: 5

    # Limits the reviews to one review per user per product.
    preference :limit_to_one_review_per_user, :boolean, default: true

    # Disable the default placment of review elements in the view files.
    preference :disable_default_review_placment, :boolean, default: false
  end
end
