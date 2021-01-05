module SpreeReviews
  class Configuration < Spree::Preferences::Configuration
    # Include non-approved reviews in (public) listings.
    preference :include_unapproved_reviews, :boolean, default: false

    # Control how many reviews are shown in summaries etc.
    preference :preview_size, :integer, default: 3

    # Show a reviewer's email address.
    preference :show_email, :boolean, default: false

    # Require login to post reviews.
    preference :require_login, :boolean, default: true

    # Whether to keep track of the reviewer's locale.
    preference :track_locale, :boolean, default: false

    # Render checkbox for a user to approve to show their identifier
    # (name or email) on their review.
    preference :show_identifier, :boolean, default: false

    # How many star rating
    preference :number_of_stars, :integer, default: 5
  end
end
