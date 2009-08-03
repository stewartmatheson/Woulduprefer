class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string :question
      t.string :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
