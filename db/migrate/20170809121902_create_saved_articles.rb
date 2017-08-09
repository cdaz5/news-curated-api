class CreateSavedArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_articles do |t|
      t.string :title
      t.string :body
      t.string :summary
      t.string :media_img_url
      t.string :source_name
      t.string :source_img_url
      t.string :author
      t.string :keywords
      t.string :hashtags
      t.integer :facebook_shares
      t.integer :linkedin_shares
      t.string :related_stories_api_call
      t.string :sentiment_polarity
      t.integer :sentiment_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
