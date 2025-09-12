class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :quiz_id
      t.text :content
      t.string :role

      t.timestamps
    end
  end
end
