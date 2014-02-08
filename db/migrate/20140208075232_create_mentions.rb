class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|

    	t.string :uid
    	t.integer :post_id
	    t.timestamps
    end
  end
end
