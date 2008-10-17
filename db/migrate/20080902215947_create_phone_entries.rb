class CreatePhoneEntries < ActiveRecord::Migration
  def self.up
    create_table :phone_entries do |t|
      t.integer :old_ddd
      t.integer :old_number, :size => 11
      t.integer :new_ddd
      t.integer :new_number, :size => 11
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :phone_entries
  end
end
