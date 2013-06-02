class AddIndexesForProgram < ActiveRecord::Migration
  def change
    add_index :programs, :started_at
  end
end
