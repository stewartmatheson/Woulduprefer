class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :question_text
      t.string :answer
      t.string :alterntive
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
