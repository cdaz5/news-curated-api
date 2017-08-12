class AddColumnToSavedArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :saved_articles, :permalink, :string
  end
end
