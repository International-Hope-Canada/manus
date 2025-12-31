class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_destroy :throw_on_undestroyable

  def throw_on_undestroyable
    throw :aboert unless destroyable?
  end

  def editable?
    true
  end

  def destroyable?
    true
  end
end
