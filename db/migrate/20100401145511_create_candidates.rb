class CreateCandidates < ActiveRecord::Migration
  def self.up
    create_table :candidates do |t|
      t.integer :code
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :candidates
  end
end
