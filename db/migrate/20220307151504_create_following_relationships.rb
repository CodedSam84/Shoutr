class CreateFollowingRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :following_relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_user_id, null: false

      t.timestamps
    end

    add_index :following_relationships, 
              [:follower_id, :followed_user_id], 
              name: :index_follower_following_relationship, 
              unique: true
  end
end
