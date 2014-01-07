class AddHasCaptionColumnToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :has_caption, :boolean
  end
end
