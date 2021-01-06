class AddIndexToShowIdentifier < ActiveRecord::Migration[5.2]
  def change
    add_index :spree_reviews, :show_identifier
  end
end
