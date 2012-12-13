class Systype < ActiveRecord::Base

  attr_accessible :id, :name, :class_key

  validates :name, :presence => true

  validates :class_key, :presence => true,
            :length => { :maximum => Const::INT_SHORT_STRING_LENGTH }

  def self.user_status_list
    Systype.where(:class_key => Const::CLASS_KEY_USER_STATUS)
  end

  def self.contact_status_list
    Systype.where(:class_key => Const::CLASS_KEY_CONTACT_STATUS)
  end

  def self.service_request_type_list
    Systype.where(:class_key => Const::CLASS_KEY_SERVICE_REQ_TYPE)
  end

  def self.service_request_status_list
    Systype.where(:class_key => Const::CLASS_KEY_SERVICE_REQ_STATUS)
  end

  def self.service_operation_type_list
    Systype.where(:class_key => Const::CLASS_KEY_SERVICE_OPER_TYPE)
  end

  def self.service_operation_status_list
    Systype.where(:class_key => Const::CLASS_KEY_SERVICE_OPER_STATUS)
  end

  def self.hardware_type_list
    Systype.where(:class_key => Const::CLASS_KEY_HARDWARE_TYPE)
  end

end
