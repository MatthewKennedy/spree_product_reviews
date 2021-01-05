class AddIndexToShowIdentifier < ActiveRecord::Migration[6.0]
  def change
    add_index :spree_reviews, :show_identifier
  end
end
