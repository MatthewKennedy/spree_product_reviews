# SpreeProductReviews

Product reviws for Spree

- No javascript
- Customizable stars
- One review per user
- Clean none cluttered
- Dedicated reviews page, SEO + Pagnation

## Installation

1. Add this extension to your Gemfile with this line:

    ```ruby
    gem 'spree_product_reviews', github: 'matthewkennedy/spree_product_reviews'
    ```

2. Install the gem using Bundler

    ```shell
    bundle install
    ```

3. Copy & run migrations

    ```shell
    bundle exec rails g spree_product_reviews:install
    ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_product_reviews/factories'
```

## Usage

Action "submit" in "reviews" controller - goes to review entry form

Users must be logged in to submit a review

Three partials:
 - `app/views/spree/products/_rating.html.erb` -- display number of stars
 - `app/views/spree/products/_shortrating.html.erb` -- shorter version of above
 - `app/views/spree/products/_review.html.erb` -- display a single review

Administrator can edit and/or approve and/or delete reviews.


## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2021 Matthew Kennedy, released under the New BSD License
