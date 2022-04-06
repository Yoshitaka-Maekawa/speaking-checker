class CreateAdvices < ActiveRecord::Migration[6.1]
  def change
    create_table :advices do |t|
      t.string :phonetic_symbol
      t.string :message

      t.timestamps
    end
  end
end
