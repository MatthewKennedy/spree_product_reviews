# frozen_string_literal: true

if Spree.version.to_f < 4.0
  Deface::Override.new(
    virtual_path: "spree/products/_cart_form",
    name: "add_stars_under_price_3_x",
    insert_before: '[data-hook="product_price"]',
    partial: "spree/shared/price_stars",
    disabled: SpreeProductReviews::Config[:disable_default_review_placment]
  )
else
  Deface::Override.new(
    virtual_path: "spree/products/_cart_form",
    name: "add_stars_under_price_4_x",
    insert_after: '[data-hook="product_price"]',
    partial: "spree/shared/price_stars",
    disabled: SpreeProductReviews::Config[:disable_default_review_placment]
  )
end

Deface::Override.new(
  virtual_path: "spree/products/show",
  name: "append_to_product_properties",
  insert_after: '[data-hook="product_properties"]',
  partial: "spree/shared/reviews",
  disabled: SpreeProductReviews::Config[:disable_default_review_placment]
)
