class Company < Contact

  has_many :business_units, :class_name => Const::MODEL_CLASS_NAME_CONTACT,
           :foreign_key => Const::STR_FIELD_NAME_PARENT_ID

  # has_many :departments, :through => :business_unit
  has_many :communities

  before_validation do
    self.type_id = Const::ID_CONTACT_TYPE_COMPANY unless self.type_id
  end

  # override class method to use a subset only
  def self.all
    # uses Company class returning objects of Company
    Company.where(:type_id => Const::ID_CONTACT_TYPE_COMPANY)
  end

  # list of all companies having status of Active
  def self.all_active
    Company.where(:type_id => Const::ID_CONTACT_TYPE_COMPANY,
                  :status_id => Const::ID_CONTACT_STATUS_ACTIVE)
  end

  def self.count
    Contact.where(:type_id => Const::ID_CONTACT_TYPE_COMPANY).count
  end

  def destroyable?
    # only in case of inactivity
    status == Const::ID_CONTACT_STATUS_INACTIVE
  end

  def business_unit_list
    BusinessUnit.where(:parent_id => id)
  end

  # TODO: implement rule checking status on change when company has
  #   business units and linked communities or user roles

end