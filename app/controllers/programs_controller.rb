class ProgramsController < ApplicationController
  before_filter :require_login
  before_filter :set_program_filter, except: [ :download ]

  def index
    @programs = @program_filter.exec.page params[:page]
  end

  def new
    @program = Program.new
  end

  def show
    @program = Program.find params[:id]
    @related = Program.where('title LIKE ?', "%#{@program.title}%").where('id NOT IN (?)', @program)
  end

  def download
    program = Program.find params[:id]
    file_path = Settings.movie.storage + '/' + program.movie_file_name
    response.headers['Content-Length'] = File.size(file_path).to_s
    send_file file_path,
      type: 'video/mp4',
      filename: program.title + ".mp4",
      length: File.size(file_path)
  end
end
