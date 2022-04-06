class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.string :evaluation, null: false
      t.string :message, null: false
      t.float :max_for_each, null: false
      t.float :min_for_each, null: false
      t.integer :max_for_total, null: false
      t.integer :min_for_total, null: false

      t.timestamps
    end
  end
end
