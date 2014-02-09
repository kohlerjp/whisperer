class AddSentimentToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :sentiment, :string, default: "neutral"
  end
end
