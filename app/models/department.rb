class Department < Contact

  belongs_to :business_unit
  belongs_to :company, :through => :business_unit

  before_validation do
    self.type_id = Const::ID_CONTACT_TYPE_DEPARTMENT unless self.type_id
  end

end