class CreateUserCommunities < ActiveRecord::Migration
  def self.up
    create_table :user_communities do |t|
      t.integer :user_id, :null => false
      t.integer :community_id, :null => false
      t.integer :enabled, :null => false
      t.integer :moderator_id, :null => false

      t.timestamps
    end
    add_index :user_communities, :user_id
    add_index :user_communities, :community_id
    add_index :user_communities, [:user_id, :community_id], :uniq => true
  end

  def self.down
    drop_table :user_communities
  end
end
