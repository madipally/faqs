class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :question_type
      t.text :options
      t.integer :number_of_times_asked
      t.string :asked_by
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating

      t.timestamps
    end
    add_index :questions, :question
  end
end
