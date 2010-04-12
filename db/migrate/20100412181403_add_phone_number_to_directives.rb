class AddPhoneNumberToDirectives < ActiveRecord::Migration
  def self.up
    add_column :directives, :phone_number, :string
  end

  def self.down
    remove_column :directives, :phone_number 
  end
end
