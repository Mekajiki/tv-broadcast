class ProgramsController < ApplicationController
  def index
    @programs = Program.all
  end

  def show
    @program = Program.find params[:id]
  end

  def download
    program = Program.find params[:id]
    send_file Settings.movie.storage + '/' + program.movie_file_name,
      type: 'video/mp4',
      filename: program.title + ".mp4"
  end
end
