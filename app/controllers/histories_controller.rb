class HistoriesController < ApplicationController
  def create
    program = Program.find params[:program_id]
    user = User.find params[:user_id]
    time = params[:time]

    history = History.where("program_id = ? AND user_id = ?",
                            program.id,
                            user.id).first
    history ||= History.create(program: program, user: user)

    history.time = time.to_i
    history.save

    respond_to do |format|
      format.json { render json:'', status: :created }
    end
  end
end
