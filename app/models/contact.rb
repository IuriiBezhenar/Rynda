class Contact < ActiveRecord::Base

  belongs_to :type, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE

  belongs_to :status, :class_name => Const::MODEL_CLASS_NAME_SYSTYPE

  belongs_to :group, :class_name => Const::MODEL_CLASS_NAME_DESCRIPTOR

  validates :name, :presence => true,
            :length => { :maximum => Const::INT_NAME_STANDARD_LENGTH }
  validates :type_id, :presence => true
  validates :status_id, :presence => true

  validates :descr, :length => { :maximum => Const::INT_DESCRIPTION_LENGTH }

end
