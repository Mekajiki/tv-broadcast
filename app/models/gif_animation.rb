class GifAnimation < ActiveRecord::Base
  belongs_to :program

  def absolute_path
    Settings.gif.storage + '/' + file_name
  end
end
