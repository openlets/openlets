class Setting < ActiveRecord::Base
  attr_accessible :name, :value
  validates_uniqueness_of :name
  validates_presence_of   :value, :name

  before_destroy :no_destroy!

  validate :name_hasnt_changed

  def self.[](name)
    Setting.find_by_name(name.to_s).value
  end

  def to_s
    "%s: %s" % [name, value]
  end

  def no_destroy!
  	errors.add :base, 'no destroying settings'
  	false
  end

  def name_hasnt_changed
    if name_changed? and !new_record? and name != 'currency_name'
  	  errors.add :name, 'no editing setting names' 
    end
  end

end