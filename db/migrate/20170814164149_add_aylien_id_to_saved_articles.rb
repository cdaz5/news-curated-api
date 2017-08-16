class AddAylienIdToSavedArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :saved_articles, :aylien_id, :integer
  end
end
