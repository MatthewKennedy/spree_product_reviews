module SpreeProductReviews
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def self.source_paths
        paths = superclass.source_paths

        paths << File.expand_path("../templates", __FILE__)
        paths.flatten
      end

      def add_files
        if Spree::Core::Engine.backend_available? || Rails.env.test?
          template "assets/images/spree-product-review-star.svg", "app/assets/images/spree-product-review-star.svg"
        end
      end

      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all.css", " *= require spree/frontend/spree_product_reviews_vars\n", before: %r{\*/}, verbose: true
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all.css", " *= require spree/frontend/spree_product_reviews\n", before: %r{\*/}, verbose: true
      end

      def add_migrations
        run "bundle exec rails railties:install:migrations FROM=spree_product_reviews"
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ["", "y", "Y"].include?(ask("Would you like to run the migrations now? [Y/n]"))
        if run_migrations
          run "bundle exec rake db:migrate"
        else
          puts "Skipping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
