class MoviePathIsString < ActiveRecord::Migration
  def change
    change_column :programs, :movie_path, :string
  end
end
