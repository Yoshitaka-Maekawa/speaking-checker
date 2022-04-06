class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :english_text, null: false
      t.integer :phase, null: false

      t.timestamps
    end
  end
end
