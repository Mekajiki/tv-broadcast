class GifAnimationsController < ApplicationController
  def create
    program = Program.find params[:program_id]

    respond_to do |format|
      begin
        gif_animation =
          Movie::Gif.convert_program(program,
                                     params[:start_at].to_i,
                                     params[:end_at].to_i)
        format.json {
          render json: { path: gif_animation_path(gif_animation) },
          status: :created }
      rescue Exception => ex
        STDERR.puts ex.message
        format.json { render json: ex.message, status: :unprocessable_entity }
      end
    end
  end

  def show
    gif_animation = GifAnimation.find params[:id]
    file_path = gif_animation.absolute_path
    response.headers['Content-Length'] = File.size(file_path).to_s
    send_file file_path,
      type: 'image/gif',
      filename: gif_animation.file_name,
      length: File.size(file_path)
  end
end
