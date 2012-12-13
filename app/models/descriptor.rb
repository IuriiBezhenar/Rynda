class Descriptor < ActiveRecord::Base

  belongs_to :type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE,
             :readonly => true

  validates :name, :presence => true,
            :length => { :maximum => Const::INT_NAME_SHORT_LENGTH }
  validates :type_id, :presence => true
  validates :descr, :length => { :maximum => Const::INT_DESCRIPTION_LENGTH }

end
