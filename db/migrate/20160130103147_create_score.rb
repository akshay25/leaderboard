class CreateScore < ActiveRecord::Migration
  def up 
    create_table :scores do |t|
	t.integer :user_id, null: false, index: true
      	t.integer :points, default: 0.0, index: true
      	t.timestamps null: false
    end

  def down 
    drop_table :scores
  end

  end
end
