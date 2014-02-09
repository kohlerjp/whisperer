class AddSentimentToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :sentiment, :integer, default: 0
  end
end
