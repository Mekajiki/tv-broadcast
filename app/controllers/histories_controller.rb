class HistoriesController < ApplicationController
  respond_to :json

  def create
    history = current_user.histories.find_or_initialize_by(program: program)
    history.time = params.require(:time)
    history.save
    respond_with program
  end

  private

  def program
    @program ||= Program.find(params.require(:program_id))
  end
end
