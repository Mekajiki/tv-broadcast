class CreateGifAnimations < ActiveRecord::Migration
  def change
    create_table :gif_animations do |t|
      t.integer :program_id
      t.string :file_name
      t.integer :start_at
      t.integer :end_at

      t.timestamps
    end
  end
end
