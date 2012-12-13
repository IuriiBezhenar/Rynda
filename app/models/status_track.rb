class StatusTrack < ActiveRecord::Base

  belongs_to :object_type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE
  belongs_to :moderator, :class_name => Const::MODEL_CLASS_NAME_USER
  belongs_to :status, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE

  def self.create_track!(object_type_id, object_id, moderator_id, status_id)
    StatusTrack.new(:object_type_id => object_type_id,
                    :object_id      => object_id,
                    :moderator_id   => moderator_id,
                    :status_id      => status_id).save!
  end
end
