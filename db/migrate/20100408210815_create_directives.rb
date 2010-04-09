class CreateDirectives < ActiveRecord::Migration
  def self.up
    create_table :directives do |t|
      t.string :instruction
      t.timestamps
    end
  end

  def self.down
    drop_table :directives
  end
end
