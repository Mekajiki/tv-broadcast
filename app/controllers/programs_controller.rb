class ProgramsController < ApplicationController
  before_filter :require_login
  before_filter :set_program_filter, except: [ :download ]

  def index
    @programs = @program_filter.exec.page params[:page]
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)

    tmp_io = params[:program][:movie]
    @program.movie_file_name = Movie::UploadHandler.save_file(tmp_io)
    @program.duration = Movie::UploadHandler.detect_duration(tmp_io.path)

    @program.ended_at = tmp_io.tempfile.ctime
    @program.started_at = @program.ended_at - @program.duration

    if @program.save
      redirect_to @program
    else
      flash.now[:error] = @program.errors
      render action: 'new'
    end
  end

  def show
    @program = Program.find params[:id]
    @related = Program.where('title LIKE ?', "%#{@program.title}%").where('id NOT IN (?)', @program)
  end

  def download
    program = Program.find params[:id]
    file_path = program.movie_absolute_path
    response.headers['Content-Length'] = File.size(file_path).to_s
    send_file file_path,
      type: 'video/mp4',
      filename: program.title + ".mp4",
      length: File.size(file_path)
  end

  def download_caption
    program = Program.find params[:id]

    if program.has_caption?
      file_path = program.caption_absolute_path

      response.headers['Content-Length'] = File.size(file_path).to_s
      send_file file_path,
        type: 'text/plain',
        filename: program.title + ".ass",
        length: File.size(file_path)
    else
      render status: 404
    end
  end

  private

  def program_params
    params.require(:program).permit(:title, :detail)
  end
end
