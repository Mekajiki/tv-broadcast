class HistoriesController < ApplicationController
  respond_to :json

  def create
    history = current_user.histories.find_or_initialize_by(program_id: params.require(:program_id))
    history.time = params.require(:time)
    history.save
    respond_with history
  end
end
