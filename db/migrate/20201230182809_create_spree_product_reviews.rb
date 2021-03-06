class CreateSpreeProductReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_reviews do |t|
      t.integer :product_id
      t.string :name
      t.string :location
      t.integer :rating
      t.string :title
      t.text :review
      t.integer :user_id
      t.string :locale, default: "en"
      t.string :ip_address
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
