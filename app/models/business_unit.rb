class BusinessUnit < Contact

  belongs_to :company, :class_name => Const::MODEL_CLASS_NAME_CONTACT,
             :foreign_key => Const::STR_FIELD_NAME_PARENT_ID
  #has_many   :departments

  validates :parent_id, :presence => true

  before_validation do
    self.type_id = Const::ID_CONTACT_TYPE_BUSINESS_UNIT unless self.type_id
  end

  def destroyable?
    #business_units.count == 0
    true
  end

end