class Selector
  # virtual model for complex selectors in object list
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :processable, :archive, :date_from, :date_to, :owned_only

  # this is mandatory method for <form_for>
  def persisted?
    false
  end
end