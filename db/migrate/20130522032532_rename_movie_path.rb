class RenameMoviePath < ActiveRecord::Migration
  def change
    rename_column :programs, :movie_path, :movie_file_name
  end
end
