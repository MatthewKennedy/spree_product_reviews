class AddReplyToSpreeReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_reviews, :reply, :text
  end
end
