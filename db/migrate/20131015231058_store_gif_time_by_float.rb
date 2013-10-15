class StoreGifTimeByFloat < ActiveRecord::Migration
  def change
    change_column :gif_animations, :start_at, :float
    change_column :gif_animations, :end_at, :float
  end
end
