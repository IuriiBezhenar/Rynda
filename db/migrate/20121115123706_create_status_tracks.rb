class CreateStatusTracks < ActiveRecord::Migration
  def self.up
    create_table :status_tracks do |t|
      t.integer :object_type_id, :null => false
      t.integer :object_id     , :null => false
      t.integer :moderator_id  , :null => false
      t.integer :status_id     , :null => false

      t.timestamps
    end

    add_index :status_tracks, [:object_type_id, :object_id, :status_id],
              :name => "index_status_tracks_on_objtype_object_status"
    add_index :status_tracks, :moderator_id
  end

  def self.down
    drop_table :status_tracks
  end
end
