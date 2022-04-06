class CreateRecordingResults < ActiveRecord::Migration[6.1]
  def change
    create_table :recording_results do |t|
      t.string :recognized_english, null: false
      t.float :average_score, null: false
      t.float :accuracy_score, null: false
      t.float :fluency_score, null: false
      t.float :completeness_score, null: false
      t.datetime :start_time, null: false
      t.references :question, null: false, foreign_key: true
      t.references :total_result, null: false, foreign_key: true
      t.references :rank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
