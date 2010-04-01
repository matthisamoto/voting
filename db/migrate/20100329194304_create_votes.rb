class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :phone_number
      t.references :candidate
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
