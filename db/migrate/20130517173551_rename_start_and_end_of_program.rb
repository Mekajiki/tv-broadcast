class RenameStartAndEndOfProgram < ActiveRecord::Migration
  def change
    rename_column :programs, :start, :started_at
    rename_column :programs, :end, :ended_at
  end
end
