class Setting < ActiveRecord::Base
  attr_accessible :name, :value
  validates_uniqueness_of :name
  validates_presence_of   :value, :name

  before_destroy :no_destroy!

  validate :name_hasnt_changed
  validate :max_debit_is_negative

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

  def max_debit_is_negative
    if name == 'maximum_debit' and value.to_i >= -10
      errors.add :value, 'maximum debit must be less than -10'
    end
  end

end