class Setting < ActiveRecord::Base
  serialize :array
  attr_accessible :name, :value, :array
  validates_uniqueness_of :name
  validates_presence_of   :name

  before_destroy :no_destroy!
  validate :name_hasnt_changed
  validate :presence_of_value_or_array 
  validate :presence_of_allowed_currency_types
  validate :presence_of_allowed_economy_types
  validate :presence_of_app_name
  validate :valid_domain

  ALLOWED_ECONOMY_TYPES  = %w(business community coop non_profit)
  ALLOWED_CURRENCY_TYPES = %w(fiat mutual_credit backed_by)

  def self.[](name)
    Setting.find_by_name(name.to_s).val
  end

  def to_s
    "%s: %s" % [name, value]
  end

  def val
    value || array
  end

  private

    def no_destroy!
      errors.add :base, 'no destroying settings'
      false
    end

    def name_hasnt_changed
      if name_changed? and !new_record? and name != 'currency_name'
        errors.add :name, 'no editing setting names' 
      end
    end

    def presence_of_value_or_array
      errors.add :base, 'value and array cant both be blank' if value.blank? and array.blank?
    end

    def presence_of_allowed_currency_types
      errors.add :array, 'You must specifiy at least one currency type' if self.name == "allowed_currency_types" && self.array.empty?
    end

    def presence_of_allowed_economy_types
      errors.add :array, 'You must specifiy at least one economy type' if self.name == "allowed_economy_types" && self.array.empty?
    end

    def presence_of_app_name
      errors.add :value, 'App name must not be empty' if self.name == "app_name" && self.value.empty?
    end

    def valid_domain
      errors.add :value, 'Domain is not valid' if self.name == "domain" && self.value.empty?
    end

    def max_debit_is_negative
      if name == 'maximum_debit' and value.to_i >= -10
        errors.add :value, 'maximum debit must be less than -10'
      end
    end

end