class PhoneEntry < ActiveRecord::Base

  validates_presence_of :name
  validates_numericality_of :old_ddd, :old_number, :new_ddd, :new_number

  def self.find_new_numbers(old_ddd, old_number)
    find_all_by_old_ddd_and_old_number(old_ddd, old_number)
  end
end
