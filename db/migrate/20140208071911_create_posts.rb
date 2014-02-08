class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :user_id
    	t.string :text
    	t.boolean :anonymous, default: true
	    t.timestamps
    end
  end
end
