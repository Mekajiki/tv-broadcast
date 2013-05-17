class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :channel_id
      t.integer :movie_path
      t.integer :event_id
      t.boolean :freeCA
      t.string :audio
      t.string :video
      t.string :attachinfo
      t.string :title
      t.string :detail
      t.text :extdetail
      t.datetime :start
      t.datetime :end
      t.integer :duration
      t.text :category

      t.timestamps
    end
  end
end
