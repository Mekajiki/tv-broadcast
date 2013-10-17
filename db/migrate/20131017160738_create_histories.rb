class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :program_id
      t.integer :user_id
      t.integer :time
      t.boolean :began
      t.boolean :completed

      t.timestamps
    end
  end
end
